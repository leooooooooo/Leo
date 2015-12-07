//
//  ViewController.m
//  QRCodeReader
//
//  Created by 吴珂 on 15/1/23.
//  Copyright (c) 2015年 吴珂. All rights reserved.
//  二维码扫描  bengkui

/*
 步骤如下：
 1.导入AVFoundation框架，引入<AVFoundation/AVFoundation.h>
 2.设置一个用于显示扫描的view
 3.实例化AVCaptureSession、AVCaptureVideoPreviewLayer
 */

#import "Scan2DCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Basic.h"

@interface Scan2DCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (retain, nonatomic) UIView *boxView;
@property (retain, nonatomic) CALayer *scanLayer;
@property BOOL isRead;
//捕捉会话
@property (nonatomic, retain) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation Scan2DCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRead = NO;
    [self startReading];
    
    UINavigationBar *nav = [[UINavigationBar alloc]init];
    [self.view addSubview:nav];
    
    //UIBarButtonItem *cancal =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    
}

-(void)startReading
{
    

    
    UIView *viewPreview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    viewPreview.backgroundColor = UUGrey;
    [self.view addSubview:viewPreview];
    

    
    _captureSession = nil;
    
    NSError *error;
    
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    //5.2.设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:viewPreview.layer.bounds];
    
    //9.将图层添加到预览view的图层上
    [viewPreview.layer addSublayer:_videoPreviewLayer];
    
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    
    //10.1.扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(viewPreview.bounds.size.width * 0.2f, viewPreview.bounds.size.height * 0.2f, viewPreview.bounds.size.width - viewPreview.bounds.size.width * 0.4f, viewPreview.bounds.size.height - viewPreview.bounds.size.height * 0.4f)];
    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    
    [viewPreview addSubview:_boxView];
    
    //提示文字
    CGRect lastFrame = _boxView.frame;
    UILabel *lblStatus = [[UILabel alloc]initWithFrame:CGRectMake(0, lastFrame.origin.y+lastFrame.size.height+20, WIDTH, 20)];
    lblStatus.textAlignment = NSTextAlignmentCenter;
    lblStatus.text = _tip;
    lblStatus.textColor = UUWhite;
    [viewPreview addSubview:lblStatus];
    
    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    
    [_boxView.layer addSublayer:_scanLayer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    
    [timer fire];
    
    //10.开始扫描
    [_captureSession startRunning];
    
    
}


-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession=nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
    [_boxView removeFromSuperview];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            if (self.isRead) {
                return;
            }
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];

            [self.Scan2DCodeDelegate Paser2DCode:[metadataObj stringValue]];
            self.isRead = YES;
        }
    }
}

- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        
        frame.origin.y += 5;
        
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}
@end
