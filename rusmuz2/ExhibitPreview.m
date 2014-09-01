//
//  ExhibitPreview.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 30/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitPreview.h"

@implementation ExhibitPreview

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        
        self.blackView = [self blackViewWithFrame:self.frame];
        [self addSubview:self.blackView];
        
        NSLog(@"init with image");
        self.number = [[UILabel alloc] initWithFrame:CGRectMake(15, 22, 100, 30)];
        [self.number setTextColor:[UIColor whiteColor]];
        [self.number setBackgroundColor:[UIColor clearColor]];
        [self.number setFont:[UIFont fontWithName: @"Helvetica Neue" size: 24.0f]];
        self.number.numberOfLines = 0;
//        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        //[self.numberLabel setText:@"1"];
        [self addSubview:self.number];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 98, 100, 30)];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
        titleLabel.numberOfLines = 0;
        //        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setText:@"НОЧЛЕГ"];
        [self addSubview:titleLabel];
        
        
        UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 100, 30)];
        [authorLabel setTextColor:[UIColor whiteColor]];
        [authorLabel setBackgroundColor:[UIColor clearColor]];
        [authorLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 6.0f]];
        authorLabel.numberOfLines = 0;
        //        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [authorLabel setText:@"ВАСНЕЦОВ"];
        [self addSubview:authorLabel];
        
    }
    return self;
}

- (UIView *)blackViewWithFrame:(CGRect)frame {
    UIView *blackView = [[UIView alloc] initWithFrame:frame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    return blackView;
}



@end
