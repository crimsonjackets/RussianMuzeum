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
        self.number.textAlignment = NSTextAlignmentLeft;
        //[self.numberLabel setText:@"1"];
        [self addSubview:self.number];
       /*
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(15, 78, 120, 50)];
        [self.title setTextColor:[UIColor whiteColor]];
        [self.title setBackgroundColor:[UIColor clearColor]];
        [self.title setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        self.title.numberOfLines = 0;
//        self.title.textAlignment = nstexta
        //[self.title setText:@"НОЧЛаааааааыаывавыаываываываываываываыаываываываываываЕГ"];
        [self addSubview:self.title];
//        [self.title sizeToFit];
        */
        
        
        self.title = [[UITextView alloc] initWithFrame:CGRectMake(15, 78, 230, 50)];
        [self.title setTextColor:[UIColor whiteColor]];
        [self.title setBackgroundColor:[UIColor clearColor]];
        [self.title setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
        //self.title.lineBreakMode = NSLineBreakByWordWrapping;
        //self.title.numberOfLines = 0;
        self.title.textAlignment = NSTextAlignmentLeft;
        //[self.title setText:@"НОЧЛаааааааыаывавыаываываываываываываыаываываываываываЕГ"];

        [self addSubview:self.title];
        [self.title setContentOffset: CGPointMake(0,0) animated:NO];
        
        //        [self alignTitleBottom];
        //        [self.title sizeToFit];
        
        
        
        self.author = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 100, 30)];
        [self.author setTextColor:[UIColor whiteColor]];
        [self.author setBackgroundColor:[UIColor clearColor]];
        [self.author setFont:[UIFont fontWithName: @"Helvetica Neue" size: 8.0f]];
        self.author.numberOfLines = 0;
        self.author.textAlignment = NSTextAlignmentLeft;
        //[self.author setText:@"ВАСНЕЦОВ"];
        [self addSubview:self.author];
        
    }
    return self;
}

- (UIView *)blackViewWithFrame:(CGRect)frame {
    UIView *blackView = [[UIView alloc] initWithFrame:frame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    return blackView;
}

-(void)alignTitleBottom {

    //Center vertical alignment
    //CGFloat topCorrect = ([_title bounds].size.height - [_title contentSize].height * [_title zoomScale])/2.0;
    //topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    //_title.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    
    //Bottom vertical alignment
    CGFloat topCorrect = ([_title bounds].size.height - [self.title contentSize].height);
    topCorrect = (topCorrect <0.0 ? 0.0 : topCorrect);
//    self.title.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    [self.title setContentOffset:(CGPoint){.x = 0, .y = -100}];
}

@end
