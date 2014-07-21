//
//  Exhibit.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 21/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;

@interface Exhibit : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * coordinates;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * qrCode;
@property (nonatomic, retain) Room *room;

@end
