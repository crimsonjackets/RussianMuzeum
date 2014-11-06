//
//  ExhibitImageView.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 06/09/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitImageView : UIImageView

@property (strong, nonatomic) UIView *blackView;

//@property (strong, nonatomic) UILabel *number;
@property (nonatomic) UIButton *infoButton;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *author;
//@property (strong, nonatomic) UILabel *info;

@end
