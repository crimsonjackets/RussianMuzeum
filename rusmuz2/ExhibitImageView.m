//
//  ExhibitImageView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 06/09/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitImageView.h"

@implementation ExhibitImageView

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        
        self.blackView = [self blackViewWithFrame:self.frame];
        [self addSubview:self.blackView];
        
        CGRect numberFrame = CGRectMake(0, 20, self.frame.size.width, 100);
        
        self.number = [[UILabel alloc] initWithFrame:numberFrame];
        [self.number setTextColor:[UIColor whiteColor]];
        [self.number setBackgroundColor:[UIColor clearColor]];
        [self.number setFont:[UIFont fontWithName: @"Helvetica Neue" size: 76.0f]];
        self.number.numberOfLines = 0;
                self.number.textAlignment = NSTextAlignmentCenter;
        //[self.number setText:@"1"];
        [self addSubview:self.number];
        
        CGRect authorFrame = CGRectMake(0, 170, self.frame.size.width, 20);
        
        self.author = [[UILabel alloc] initWithFrame:authorFrame];
        [self.author setTextColor:[UIColor whiteColor]];
        [self.author setBackgroundColor:[UIColor clearColor]];
        [self.author setFont:[UIFont fontWithName: @"Helvetica Neue" size: 12.0f]];
        self.author.numberOfLines = 0;
        self.author.textAlignment = NSTextAlignmentCenter;
        //[self.author setText:@"ВАСНЕЦОВ"];
        [self addSubview:self.author];
        
        CGRect infoFrame = CGRectMake(0, 200, self.frame.size.width, 100);
        
        self.info = [[UILabel alloc] initWithFrame:infoFrame];
        [self.info setTextColor:[UIColor whiteColor]];
        [self.info setBackgroundColor:[UIColor clearColor]];
        [self.info setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
        self.info.numberOfLines = 0;
        self.info.textAlignment = NSTextAlignmentCenter;
        //[self.info setText:@"НОЧЛЕГ"];
        [self addSubview:self.info];
        
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
