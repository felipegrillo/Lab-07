//
//  ViewController.m
//  Lab-07
//
//  Created by felipe on 19/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import "ViewController.h"
NSString    *strUserLocation;
float       mlatitude;
float       mlongitude;

GMSMapView *mapView;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  /*  self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager  requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];*/
    // Do any additional setup after loading the view.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:17.0579145
                                                            longitude:-96.7291646
                                                                 zoom:13
                                                              bearing:30
                                                         viewingAngle:0];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.mapType=kGMSTypeNormal;
    mapView.myLocationEnabled = YES;
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    
    [mapView addObserver:self
              forKeyPath:@"myLocation"
                 options:NSKeyValueObservingOptionNew
                 context:NULL];
    //[self.viewMap addSubview:mapView];
    self.view=mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)paintMap
{
    //-------------------------------------------------------------------------------
    //Google Maps
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude
                                                            longitude:mlongitude
                                                                 zoom:16];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame = CGRectMake(0, 0, self.viewMap.frame.size.width, self.viewMap.frame.size.height);
    mapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    marker.title = @"Master UAG";
    marker.snippet = @"A punto de salir!";
    marker.map = mapView;
    [self.viewMap
     addSubview:mapView];
}
/**********************************************************************************************
 Localization
 **********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
    NSLog( @"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             NSString *addressName = [placemark name];
             NSString *city = [placemark locality];
             NSString *administrativeArea = [placemark administrativeArea];
             NSString *country  = [placemark country];
             NSString *countryCode = [placemark ISOcountryCode];
             NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             NSLog(@"gstrUserLocation = %@", strUserLocation);
         }
         mlatitude = self.locationManager.location.coordinate.latitude;
         //[mUserDefaults setObject: [[NSNumber numberWithFloat:mlatitude] stringValue] forKey: pmstrLatitude];
         mlongitude = self.locationManager.location.coordinate.longitude;
         //[mUserDefaults setObject: [[NSNumber numberWithFloat:mlatitude] stringValue] forKey: pmstrLatitude];
         NSLog(@"mlatitude = %f", mlatitude);
         NSLog(@"mlongitude = %f", mlongitude);
     }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnPressed:(id)sender {
  //  [self paintMap];
}
@end
