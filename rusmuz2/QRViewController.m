//
//  QRViewController.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 12/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "QRViewController.h"
#import "ExhibitViewController.h"

@interface QRViewController ()
@property (nonatomic, strong) NSString *QRCode;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property BOOL scanned;

@end

@implementation QRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scanned = NO;
    [self startReading];
    
    _captureSession = nil;

}


- (BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return YES;
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if (_scanned == NO) {
            if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
                NSLog(@"QR CODE SCANNED");
                _scanned = YES;
                [_QRCode performSelectorOnMainThread:@selector(setQRCode:) withObject:[metadataObj stringValue] waitUntilDone:NO];
                [self performSelectorOnMainThread:@selector(pushVC) withObject:nil waitUntilDone:NO];
                [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
                
            }
        }

    }
}

- (void)pushVC {
//    ExhibitViewController *vc = [[ExhibitViewController alloc] init];
//    vc.exhibitQRCode = _QRCode;
//    [self.navigationController pushViewController:vc animated:YES];
    [self performSegueWithIdentifier:@"QRtoExhibit" sender:self];
    
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    
    [_videoPreviewLayer removeFromSuperlayer];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"QRtoExhibit"]) {
//        
//        if ([segue.destinationViewController respondsToSelector:@(setExhibitQRCode)]) {
//            [segue.destinationViewController performSelector:@(setExhibitQRCode) withObject:_QRCode];
//        }
//
//        
//        
        //[segue.destinationViewController setexhibitQRCode];
        ExhibitViewController *destination = segue.destinationViewController;
        destination.exhibitQRCode = self.QRCode;
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(id)sender {
    //REWRITE THIS!!!
    [self dismissViewControllerAnimated:self completion:nil];
}
@end
