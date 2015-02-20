//
//  ViewController.h
//  Lab-07
//
//  Created by felipe on 19/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
@interface ViewController :UIViewController<CLLocationManagerDelegate, GMSMapViewDelegate>
@property (strong, nonatomic) CLLocationManager     *locationManager;
@property (strong, nonatomic) CLLocation            *location;
@property (strong, nonatomic) IBOutlet UIView *viewMap;
- (IBAction)btnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnMap;
@end
