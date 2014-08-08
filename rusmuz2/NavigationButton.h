//
//  NavigationButton.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 04/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationButtonDelegate.h"
@interface NavigationButton : UIButton

@property (nonatomic, weak) id <NavigationButtonDelegate> delegate;
@property (nonatomic) ButtonKind buttonKind;
@property (strong, nonatomic) NSNumber *currentFloor;

@end
