//
//  QRViewController.m
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "QRViewController.h"
#import "ZBarSDK.h"



@interface QRViewController ()

@end

@implementation QRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
//    if ([qrcodes objectForKey:_textQRCode] != nil) {
//        _textviewQRCode.text = [qrcodes objectForKey:_textQRCode];
//    } else {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
//                                                          message:@"This is your first UIAlertview message."
//                                                         delegate:nil
//                                                cancelButtonTitle:@"OK"
//                                                otherButtonTitles:nil];
//        
//        [message show];    }

    DatabaseManager *databaseManager = [DatabaseManager sharedInstance];
    
    if ([databaseManager.exhibits objectForKey:_textQRCode] != nil) {
        _textviewQRCode.text = [databaseManager.exhibits objectForKey:_textQRCode];
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                          message:@"This is your first UIAlertview message."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
