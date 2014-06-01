//
//  DatabaseManager.h
//  rusmuz
//
//  Created by Richard Topchiy on 23/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

+ (DatabaseManager*)sharedInstance;

@property (nonatomic,strong) NSDictionary *exhibits;


@end
