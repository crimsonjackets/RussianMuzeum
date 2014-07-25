//
//  QRViewController.m
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitViewController.h"
#import "ZBarSDK.h"



@interface ExhibitViewController ()

@end

@implementation ExhibitViewController

- (void)viewDidLoad
{
    DatabaseManager *databaseManager = [DatabaseManager sharedInstance];
    
    if ([databaseManager.exhibits objectForKey:_textQRCode] != nil) {
        _textviewQRCode.text = [databaseManager.exhibits objectForKey:_textQRCode];
    }
    
    
    [self addImages];
    
    
}



- (void)addImages
{
    UIImage *pic1 = [UIImage imageNamed:@"pic1.png"];
    UIImage *pic2 = [UIImage imageNamed:@"pic2.png"];
    UIImage *pic3 = [UIImage imageNamed:@"pic3.png"];
    
    UIImageView *one = [[UIImageView alloc] initWithImage:pic1];
    UIImageView *two = [[UIImageView alloc] initWithImage:pic2];
    UIImageView *three = [[UIImageView alloc] initWithImage:pic3];
    
    one.frame = CGRectMake(0, 0, pic1.size.width, pic1.size.height);
    two.frame = CGRectMake(pic1.size.width, 0, pic2.size.width, pic2.size.height);
    three.frame = CGRectMake(pic1.size.width + pic2.size.width, 0, pic3.size.width, pic3.size.height);
    
    
    CGSize contentSize = CGSizeMake(pic1.size.width + pic2.size.width + pic3.size.width, pic1.size.height);
    
    [self.imageScrollView setContentSize:contentSize];
    [self.imageScrollView addSubview:one];
    [self.imageScrollView addSubview:two];
    [self.imageScrollView addSubview:three];
}

@end
