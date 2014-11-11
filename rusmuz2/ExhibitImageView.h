//
//  ExhibitImageView.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 06/09/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitTappedDelegate.h"

@interface ExhibitImageView : UIImageView


@property (nonatomic, assign) id <ExhibitTappedDelegate> exhibitTappedDelegate;

//@property (strong, nonatomic) UILabel *number;
@property (nonatomic) NSInteger number;
@property (nonatomic) UIButton *infoButton;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *author;
//@property (strong, nonatomic) UILabel *info;

@property (nonatomic) UIButton *videoButton;
@end
