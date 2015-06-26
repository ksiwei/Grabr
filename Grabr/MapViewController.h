//
//  MapViewController.h
//  Grabr
//
//  Created by Kang, Siwei on 5/30/15.
//  Copyright (c) 2015 swayy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapViewController : UIViewController <MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;

- (IBAction)takePicture:(id)sender;


@end

