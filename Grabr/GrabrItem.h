//
//  GrabrItem.h
//  Grabr
//
//  Created by Siwei Kang on 6/23/15.
//  Copyright (c) 2015 swayy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GrabrItem : NSObject

@property (nonatomic, copy, readonly) NSString *image;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) BOOL isAvailable;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
