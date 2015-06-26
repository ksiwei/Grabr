//
//  MapViewController.m
//  Grabr
//
//  Created by Kang, Siwei on 5/30/15.
//  Copyright (c) 2015 swayy. All rights reserved.
//

#import "MapViewController.h"
#import "PostItemViewController.h"
#import "GrabrAnnotationView.h"
#import "GrabrAnnotation.h"
#import "GrabrItem.h"
#import <Firebase/Firebase.h>

static NSString * const baseURL = @"https://crackling-fire-2973.firebaseio.com/locations/seattle/items";

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *itemMap;

@end

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.itemMap.delegate = self;

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //iOS 8 API change
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }else{
        [self.locationManager startUpdatingLocation];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //start listening for new items
    [self listenForItems];
    
    //map items on the MapView
    
    //find current location
}

- (void)listenForItems {
    Firebase *ref = [[Firebase alloc] initWithUrl:baseURL];
    // listen for new users
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
    
            // check to see if user was updated or removed
            if (snapshot.value != [NSNull null]) {
                NSLog(@"Values :%@ , %@", snapshot.key, snapshot.value);
                NSLog(@"lat : %@ lng : %@", snapshot.value[@"lat"], snapshot.value[@"lng"]);
                
                GrabrItem *item = [[GrabrItem alloc] initWithDictionary:snapshot.value];
                [self addMarker:item];
            }
    }];
}


- (IBAction)takePicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark delegate imagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.title = @"Items Map";
    
    NSDictionary *metadata = [info objectForKey: UIImagePickerControllerMediaMetadata];
    NSLog(@"%@",metadata);

    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];

    
    PostItemViewController *postItemViewController = [[PostItemViewController alloc] init];
    [postItemViewController configureWithImage:chosenImage];
    
    [self.navigationController pushViewController:postItemViewController animated:YES];
}

#pragma mark delegate CLLocationManager

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation * currentLocation = (CLLocation *)[locations lastObject];
    NSLog(@"Location: %@", currentLocation);
    //todo: zoom out until the region includes a marker
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 3000, 3000);
    [self.itemMap setRegion:[self.itemMap regionThatFits:region] animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            // do some error handling
        }
            break;
        default:{
            [self.locationManager startUpdatingLocation];
        }
            break;
    }
}

- (void)addMarker:(GrabrItem *)item{
    // Add an annotation
    GrabrAnnotation *point = [[GrabrAnnotation alloc] initWithGrabrItem:item];
    //TODO add image
    
    [self.itemMap addAnnotation:point];
    
   // MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 800, 800);
   // [self.itemMap setRegion:[self.itemMap regionThatFits:region] animated:YES];
}

#pragma mark MapViewDelegate
//http://stackoverflow.com/questions/4094325/customizing-the-mkannotation-callout-bubble?lq=1
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else if ([annotation isKindOfClass:[GrabrAnnotation class]]) // use whatever annotation class you used when creating the annotation
    {
        static NSString * const identifier = @"MyCustomAnnotation";
        GrabrAnnotation *grabrAnnotation = (GrabrAnnotation *)annotation;
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = NO;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:grabrAnnotation.item.image]]];
        annotationView.image = image;
        
        return annotationView;
    }
    return nil;
}


@end
