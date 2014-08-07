//
//  NavigationButtonDelegate.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 06/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavigationButtonDelegate <NSObject>

@optional
- (void)homeButtonPressed;
- (void)mapButtonPressed;
- (void)changeFloorButtonPressed;
- (void)exhibitButtonPressed;
@end
