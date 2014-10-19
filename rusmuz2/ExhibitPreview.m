//
//  ExhibitPreview.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 30/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitPreview.h"

#define PREVIEW_HEIGHT 146


@implementation ExhibitPreview


- (ExhibitPreview *)initWithExhibit:(Exhibit *)exhibit {
    UIImage *image = [UIImage imageWithData:exhibit.picture scale:2];
    
    ExhibitPreview *exhibitPreview =[[ExhibitPreview alloc] initWithImage:image];
    
    exhibitPreview.author.text = exhibit.author;
    exhibitPreview.title.text = exhibit.name;

    return exhibitPreview;
}

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        self.userInteractionEnabled = YES;
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGRect frame = CGRectMake(0.0f, 0.0f, screenWidth/2, PREVIEW_HEIGHT);
        self.frame = frame;

        //LEFT-RIGHT based code

        self.blackView = [self blackViewWithFrame:self.bounds];
        [self addSubview:self.blackView];

        
        NSLog(@"PREVIEW BOUNDS: %f", self.bounds.size.width);
        NSLog(@"PREVIEW BOUNDS: %f", self.bounds.size.height);
        
        NSLog(@"init with image");

        self.number = [[UILabel alloc] initWithFrame:CGRectMake(15, 22, 100, 30)];
        [self.number setTextColor:[UIColor whiteColor]];
        [self.number setBackgroundColor:[UIColor clearColor]];
        [self.number setFont:[UIFont fontWithName: @"Helvetica Neue" size: 24.0f]];
        self.number.numberOfLines = 0;
        self.number.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.number];
        
        
        self.title = [[UITextView alloc] initWithFrame:CGRectMake(10, 78, 140, 50)];
        [self.title setTextColor:[UIColor whiteColor]];
        [self.title setBackgroundColor:[UIColor clearColor]];
        [self.title setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
        //self.title.lineBreakMode = NSLineBreakByWordWrapping;
        //self.title.numberOfLines = 0;
        self.title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.title];
        [self.title setContentOffset: CGPointMake(0,0) animated:NO];
        self.title.userInteractionEnabled = NO;
        
        self.author = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 140, 30)];
        [self.author setTextColor:[UIColor whiteColor]];
        [self.author setBackgroundColor:[UIColor clearColor]];
        [self.author setFont:[UIFont fontWithName: @"Helvetica Neue" size: 8.0f]];
        self.author.numberOfLines = 0;
        self.author.textAlignment = NSTextAlignmentLeft;
        //[self.author setText:@"ВАСНЕЦОВ"];
        [self addSubview:self.author];
        
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;

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




- (ExhibitPreview *)copy {
    ExhibitPreview *exhibitPreview =[[ExhibitPreview alloc] initWithImage:self.image];
    
    exhibitPreview.number.text = self.number.text;
    exhibitPreview.author.text = self.author.text;
    exhibitPreview.title.text = self.title.text;
    
    
    exhibitPreview.contentMode = UIViewContentModeScaleAspectFill;
    exhibitPreview.clipsToBounds = YES;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGRect frame = CGRectMake(0.0f, 0.0f, screenWidth/2, PREVIEW_HEIGHT);
    exhibitPreview.frame = frame;

    return exhibitPreview;
}

@end
