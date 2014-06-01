//
//  ViewController.h
//  rusmuz
//
//  Created by Richard Topchiy on 13/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "DatabaseManager.h"


@interface ViewController : UIViewController <ZBarReaderDelegate>
@property (strong, nonatomic) NSString *outText;
@property (strong, nonatomic) NSDictionary *context;

- (IBAction)buttonStart:(id)sender;




@end
