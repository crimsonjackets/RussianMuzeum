//
//  Exhibit.h
//  rusmuz2
//
//  Created by Richard Topchiy on 30/06/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exhibit : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * qrCode;
@property (nonatomic, retain) NSManagedObject *room;

@end
