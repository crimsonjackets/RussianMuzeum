//
//  QRViewController.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 12/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewPreview;

- (IBAction)cancelButton:(id)sender;

@end
