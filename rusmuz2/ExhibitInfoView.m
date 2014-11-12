//
//  ExhibitInfoView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 11/11/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitInfoView.h"

#define INFO_ANIMATIONS_DURATION 0.3f

@interface ExhibitInfoView ()

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic) UITextView *infoTextView;

@end



@implementation ExhibitInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.liveBlurring = NO;
        self.blurRadius = 6.0f;
        self.alpha = 0.0f;
    }
    return self;
}

- (void)animateIn {
        [self createTexts];
    [self animateBlurViewIn];


}

- (void)animateOut {
        self.liveBlurring = YES;
    [self animateTextViewOut];
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

- (void)animateBlurViewIn {
    self.liveBlurring = YES;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.liveBlurring = NO;
        [self animateTextsIn];
    }];
}

- (void)createTexts {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width - 40, 20)];
    [title setTextColor:[UIColor whiteColor]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName: @"Helvetica Neue" size: 24.0f]];
    title.lineBreakMode = NSLineBreakByWordWrapping;
    //title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    title.text = _title;
    title.alpha = 0;
    _titleLabel = title;
    [self addSubview:title];
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.bounds.size.width- 40, 20)];
    [author setTextColor:[UIColor whiteColor]];
    [author setBackgroundColor:[UIColor clearColor]];
    [author setFont:[UIFont fontWithName: @"Helvetica Neue" size: 16.0f]];
    author.numberOfLines = 0;
    author.textAlignment = NSTextAlignmentCenter;
    author.text = _author;
    author.alpha = 0;
    _authorLabel  = author;
    [self addSubview:author];
    
    
    UITextView *textview = [[UITextView alloc] initWithFrame:self.bounds];
    textview.text = _info;
    [textview setCenter:CGPointMake(textview.center.x, author.center.y + author.frame.size.height + textview.frame.size.height/2)];
    textview.backgroundColor = [UIColor clearColor];
    textview.textColor = [UIColor whiteColor];
    textview.alpha = 0;
    textview.textAlignment = NSTextAlignmentJustified;
    _infoTextView = textview;
    [self addSubview:textview];
}

- (void)animateTextsIn {
    [UIView animateWithDuration:0.2f animations:^{
        _titleLabel.alpha = 1;
        _authorLabel.alpha = 1;
        _infoTextView.alpha = 1;
    }];
}

- (void)animateTextViewOut {
    [UIView animateWithDuration:INFO_ANIMATIONS_DURATION animations:^{
        _titleLabel.alpha = 0;
        _authorLabel.alpha = 0;
        _infoTextView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}




+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
