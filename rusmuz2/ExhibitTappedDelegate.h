//
//  ExhibitTappedDelegate.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 19/10/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ExhibitTappedDelegate <NSObject>

@optional
- (void)exhibitSelected:(NSInteger)exhibitNumber;
- (void)exhibitInfoSelected:(NSInteger)exhibitNumber;
@end
