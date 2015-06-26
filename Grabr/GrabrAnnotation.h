//
//  GrabrAnnotation.h
//  Grabr
//
//  Created by Siwei Kang on 6/23/15.
//  Copyright (c) 2015 swayy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GrabrItem.h"

@interface GrabrAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong, readonly) GrabrItem *item;

- (id)initWithGrabrItem:(GrabrItem *)item;

@end
