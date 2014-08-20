//
//  Event.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 20/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;

@end
