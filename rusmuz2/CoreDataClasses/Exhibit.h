//
//  Exhibit.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 10/11/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;

@interface Exhibit : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * coordinates;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * qrCode;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * videoURL;
@property (nonatomic, retain) Room *room;

@end
