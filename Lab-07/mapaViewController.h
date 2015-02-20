//
//  mapaViewController.h
//  Lab-07
//
//  Created by felipe on 18/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>

@interface mapaViewController : UIViewController <CLLocationManagerDelegate,GMSMapViewDelegate,ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
    NSArray *nombre;


}
@property (copy,nonatomic) NSSet *markers;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *location;
@property (strong, nonatomic) IBOutlet UIView *viewMap;
@property (strong, nonatomic) IBOutlet UIButton *btnMaps;

- (IBAction)btnMap:(id)sender;



@end
