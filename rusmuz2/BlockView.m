//
//  BlockView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 31/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView
/*
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.redView = [self redViewWithFrame:self.frame];
        [self addSubview:self.redView];
    }
    return self;
}

- (void)setInteger:(NSInteger)integer {
    NSString *string = [NSString stringWithFormat:@"%ld", (long)integer];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.numberLabel setTextColor:[UIColor whiteColor]];
    [self.numberLabel setBackgroundColor:[UIColor clearColor]];
    [self.numberLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 24.0f]];
    self.numberLabel.numberOfLines = 0;
    //        descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.numberLabel setText:string];
    [self setNumberLabel:label];
}

- (void)setNumberLabel:(UILabel *)numberLabel {

    [self addSubview:numberLabel];
}

*/

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        //self.redView = [self redViewWithFrame:self.frame];
        //[self addSubview:self.redView];
        
        NSLog(@"init with image");
        //        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        self.numberLabel = [[UILabel alloc] initWithFrame:self.frame];
        [self.numberLabel setTextColor:[UIColor whiteColor]];
        [self.numberLabel setBackgroundColor:[UIColor clearColor]];
        [self.numberLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
        self.numberLabel.numberOfLines = 0;
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        //[self.numberLabel setText:@"1"];
        [self addSubview:self.numberLabel];
    }
    return self;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.redView = [self redViewWithFrame:self.frame];
//        [self addSubview:self.redView];
//        
//        NSLog(@"init with image");
//        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 22, 100, 30)];
//        [self.numberLabel setTextColor:[UIColor whiteColor]];
//        [self.numberLabel setBackgroundColor:[UIColor clearColor]];
//        [self.numberLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 24.0f]];
//        self.numberLabel.numberOfLines = 0;
//        //        descriptionLabel.textAlignment = NSTextAlignmentCenter;
//        [self.numberLabel setText:@"1"];
//        [self addSubview:self.numberLabel];
//    }
//    return self;
//}

- (UIView *)redViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor redColor];
    view.alpha = 1;
    return view;
}

@end
