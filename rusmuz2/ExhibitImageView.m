//
//  ExhibitImageView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 06/09/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitImageView.h"

@interface ExhibitImageView ()
@property (strong, nonatomic) UIView *blackView;
@end


@implementation ExhibitImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        
        
        self.blackView = [self blackViewWithFrame:self.bounds];
        [self addSubview:self.blackView];
    

        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, self.frame.size.width, 20)];
        [self.title setTextColor:[UIColor whiteColor]];
        [self.title setBackgroundColor:[UIColor clearColor]];
        [self.title setFont:[UIFont fontWithName: @"Helvetica Neue" size: 24.0f]];
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        //self.title.numberOfLines = 0;
        self.title.textAlignment = NSTextAlignmentCenter;
        //[self.title setText:@"Последний день Помпеи"];
        [self addSubview:self.title];
        
        
        CGRect authorFrame = CGRectMake(0, 180, self.frame.size.width, 20);
        self.author = [[UILabel alloc] initWithFrame:authorFrame];
        [self.author setTextColor:[UIColor whiteColor]];
        [self.author setBackgroundColor:[UIColor clearColor]];
        [self.author setFont:[UIFont fontWithName: @"Helvetica Neue" size: 16.0f]];
        self.author.numberOfLines = 0;
        self.author.textAlignment = NSTextAlignmentCenter;
        //[self.author setText:@"ВАСНЕЦОВ"];
        [self addSubview:self.author];
        
        [self setContentMode:UIViewContentModeScaleAspectFill];
        self.clipsToBounds = YES;
        
        self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [_infoButton setTintColor:[UIColor redColor]];
        _infoButton.center = CGPointMake(self.frame.size.width / 2, 90);
        [_infoButton addTarget:self.exhibitTappedDelegate action:@selector(exhibitInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_infoButton];

        
        /*
         CGRect numberFrame = CGRectMake(0, 20, self.frame.size.width, 100);
         
         self.number = [[UILabel alloc] initWithFrame:numberFrame];
         [self.number setTextColor:[UIColor whiteColor]];
         [self.number setBackgroundColor:[UIColor clearColor]];
         [self.number setFont:[UIFont fontWithName: @"Helvetica Neue" size: 76.0f]];
         self.number.numberOfLines = 0;
         self.number.textAlignment = NSTextAlignmentCenter;
         //[self.number setText:@"1"];
         [self addSubview:self.number];
         */
        
        
        
        /*
         CGRect infoFrame = CGRectMake(0, 200, self.frame.size.width, 100);
         
         self.info = [[UILabel alloc] initWithFrame:infoFrame];
         [self.info setTextColor:[UIColor whiteColor]];
         [self.info setBackgroundColor:[UIColor clearColor]];
         [self.info setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
         self.info.numberOfLines = 0;
         self.info.textAlignment = NSTextAlignmentCenter;
         //[self.info setText:@"НОЧЛЕГ"];
         [self addSubview:self.info];
         */
        
    }
    return self;
}

- (void)setNumber:(NSInteger)number {
    _infoButton.tag = number;
    _number = number;
}

- (UIView *)blackViewWithFrame:(CGRect)frame {
    UIView *blackView = [[UIView alloc] initWithFrame:frame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    return blackView;
}

@end
