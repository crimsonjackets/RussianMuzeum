//
//  Exhibit.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 09/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;

@interface Exhibit : NSManagedObject

@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * coordinates;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * qrCode;
@property (nonatomic, retain) Room *room;

@end
