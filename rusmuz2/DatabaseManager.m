//
//  DatabaseManager.m
//  rusmuz
//
//  Created by Richard Topchiy on 23/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

#pragma mark - Singleton Methods

+ (DatabaseManager*)sharedInstance {
    
    static DatabaseManager *_sharedInstance;
    if(!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        // Custom initialization
        _exhibits = [[NSMutableDictionary alloc] init];
    }
    return self;
}
@end
