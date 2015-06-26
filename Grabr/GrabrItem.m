//
//  GrabrItem.m
//  Grabr
//
//  Created by Siwei Kang on 6/23/15.
//  Copyright (c) 2015 swayy. All rights reserved.
//

#import "GrabrItem.h"

@implementation GrabrItem

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _image = [[dict objectForKey:@"image"] copy];
        _isAvailable = [[dict objectForKey:@"status"] isEqualToString:@"available"];
        _coordinate = CLLocationCoordinate2DMake([dict[@"location"][@"lat"] doubleValue], [dict[@"location"][@"lng"] doubleValue]);
    }
    
    return self;
}

@end
