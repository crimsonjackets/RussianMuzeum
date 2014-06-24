//
//  QRViewController.h
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ViewController.h"
#import "ZBarSDK.h"
#import "DatabaseManager.h"

@interface QRViewController : UIViewController <ZBarReaderDelegate>

@property (strong, nonatomic) NSString *textQRCode;
@property (weak, nonatomic) IBOutlet UITextView *textviewQRCode;


@end
