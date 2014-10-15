//
//  QRController.m
//  JDQR
//
//  Created by raoyuanjie on 14-10-14.
//  Copyright (c) 2014年 raoyuanjie. All rights reserved.
//

#import "QRController.h"
#import <AVFoundation/AVFoundation.h>
#import "CommonMacro.h"


@interface QRController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic) BOOL isReading;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) UIImageView *imgViewLine;
@end




@implementation QRController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startReading];

    UIImageView *imgViewBorder = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH-60, SCREEN_WIDTH-60)];
    UIImage *img=[UIImage imageNamed:@"qrcode_border"];
    img =[img resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    imgViewBorder.image=img;
    [self.view.layer addSublayer:imgViewBorder.layer];
    
    _imgViewLine=[[UIImageView alloc]initWithFrame:CGRectMake(31, -SCREEN_WIDTH+60, SCREEN_WIDTH-62, SCREEN_WIDTH-60)];
    _imgViewLine.image=[UIImage imageNamed:@"qrcode_scanline_qrcode"];
    [self.view.layer addSublayer:_imgViewLine.layer];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
}

-(void)lineAnimation
{
    _imgViewLine.hidden=NO;
    [UIView animateWithDuration:1 animations:^{
        
        _imgViewLine.frame=CGRectMake(31, 110, SCREEN_WIDTH-62, SCREEN_WIDTH-60);
        _imgViewLine.alpha=.5;
    } completion:^(BOOL finished) {
        _imgViewLine.hidden=YES;
        _imgViewLine.frame=CGRectMake(31, -SCREEN_WIDTH+60, SCREEN_WIDTH-62, SCREEN_WIDTH-60);
    }];
}

- (BOOL)startReading {
    _isReading = YES;
    NSError *error;
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];

    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    if (self.qrcodeFlag)
        [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    else
        [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
    [self.view.layer addSublayer:_videoPreviewLayer];
    [_captureSession startRunning];
    
    return YES;
}


-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (!_isReading) return;
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        [self stopReading];

        NSLog(@"string==%@",metadataObj.stringValue);
                //Do Something....
        
        
        
    }
}
- (IBAction)albumPhoto:(id)sender
{
    [self photoAlbum];
}



- (IBAction)torch:(id)sender
{
    //set the troch
    [_captureDevice lockForConfiguration:nil];
    _captureDevice.torchMode = !_captureDevice.torchActive;
}


-(void)photoAlbum
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:picker animated:YES];//进入照相界面
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
