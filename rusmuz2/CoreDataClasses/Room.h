//
//  Room.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 10/11/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exhibit;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSSet *exhibits;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addExhibitsObject:(Exhibit *)value;
- (void)removeExhibitsObject:(Exhibit *)value;
- (void)addExhibits:(NSSet *)values;
- (void)removeExhibits:(NSSet *)values;

@end
