//
//  GrabrAnnotation.m
//  Grabr
//
//  Created by Siwei Kang on 6/23/15.
//  Copyright (c) 2015 swayy. All rights reserved.
//

#import "GrabrAnnotation.h"

@implementation GrabrAnnotation

- (id)initWithGrabrItem:(GrabrItem *)item {
    if (self = [super init]) {
        _coordinate = item.coordinate;
        _item = item;
    }
    
    return self;
}

@end
