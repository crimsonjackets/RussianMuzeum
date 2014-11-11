//
//  ExhibitInfoView.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 11/11/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "LFGlassView.h"

@interface ExhibitInfoView : LFGlassView

@property (nonatomic) NSString *picture;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *info;


- (void)animateIn;

@end
