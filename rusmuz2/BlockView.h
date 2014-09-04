//
//  BlockView.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 31/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockView : UIImageView

@property (strong, nonatomic) UIView *redView;
@property (nonatomic, strong) UILabel *numberLabel;
@property BOOL active;

- (void)setInteger:(NSInteger)integer;


@end
