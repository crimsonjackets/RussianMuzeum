//
//  ExhibitPreview.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 30/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitPreview : UIImageView

@property (strong, nonatomic) UIView *blackView;

@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *author;

@end
