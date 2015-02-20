//
//  mapaViewController.m
//  Lab-07
//
//  Created by felipe on 18/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import "mapaViewController.h"
#import "Home.h"


NSString    *strUserLocation;
float       mlatitude;
float       mlongitude;

NSString    *Location;
NSString    *Description;
float       mlat;
float       mlong;
GMSMapView *mapView;
NSSet *markers;
@interface mapaViewController ()
@end
@implementation mapaViewController




- (void)viewDidLoad {
   
     [super viewDidLoad];
 [self iAdBanner];
    //Location
    
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager  requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    

    
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
                                                                 zoom:13];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    mapView.frame = CGRectMake(0, 0, self.viewMap.frame.size.width, self.viewMap.frame.size.height);
    mapView.delegate=self;
    mapView.mapType=kGMSTypeNormal;
    mapView.myLocationEnabled = YES;
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    //mapView.myLocationEnabled = YES;
    [self imprimeMarkers];
       [self.viewMap addSubview:mapView];
    // Creates a marker in the center of the map.
    
    
  //  self.view=mapView;
    
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
- (void)iAdBanner
{
    // Setup iAdView
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    //Set coordinates for adView
    CGRect adFrame      = adView.frame;
    adFrame.origin.y    = self.view.frame.size.height - 50;
    // NSLog(@"adFrame.origin.y: %f",adFrame.origin.y);
    adView.frame        = adFrame;
    
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.viewMap addSubview:adView];
    adView.delegate         = self;
    adView.hidden           = YES;
    self->bannerIsVisible   = NO;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self->bannerIsVisible)
    {
        adView.hidden = NO;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        [UIView commitAnimations];
        self->bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self->bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        [UIView commitAnimations];
        adView.hidden = YES;
        self->bannerIsVisible = NO;
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Banner view is beginning an ad action");
    BOOL shouldExecuteAction = YES;
    if (!willLeave && shouldExecuteAction)
    {
        // stop all interactive processes in the app
        // [video pause];
        // [audio pause];
    }
    return shouldExecuteAction;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // resume everything you've stopped
    // [video resume];
    // [audio resume];
}
- (void) imprimeMarker{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    marker.title = @"IEEPO";
    marker.snippet = @"Desesperacion Total con Xcode!";
    marker.map = mapView;
    

}

- (void) imprimeMarkers{
    PFQuery *query = [PFQuery queryWithClassName:@"Ubicacion"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            nombre=[[NSArray alloc] initWithArray:objects];
            
        }
       
        
    }];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    marker.title = @"IEEPO";
    marker.snippet = @"Desesperacion Total con Xcode!";
    marker.map = mapView;
 //   NSSet *arrayMarkes=[[NSSet alloc] init];
    for (NSArray  *arr in nombre) {
    
        Location=[arr valueForKey:@"Name"];
        mlat=[[arr valueForKey:@"Latitud"] floatValue];
        mlong=[[arr valueForKey:@"Longitud"] floatValue];
        NSLog(@"Nombre....... Location %@",Location);
        NSLog(@"Latitude....... latitude %f",mlat);
        NSLog(@"Longitude....... Longitude%f",mlong);
         GMSMarker *mark = [[GMSMarker alloc] init];
        mark.position = CLLocationCoordinate2DMake(mlat, mlong);
        mark.title =Location;
        mark.snippet = @"Desesperacion Total con Xcode!";
        mark.map = mapView;
       
    }
    

}
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    // coordinate contains your coordinate :)
    NSLog(@"did tap at coordinate: (%f, %f)", coordinate.latitude, coordinate.longitude);
}

-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker
{
  /*  NSURLSessionConfiguration *configuratin = [NSURLSessionConfiguration defaultSessionConfiguration];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:configuratin];
    if(mapView.myLocation!=nil){
        NSString *urlString = [NSString stringWithFormat:
                               @"%@?origin=%f,%f&destination=%f,%f&sensor=true&key=%@",
                               @"https://maps.googleapis.com/maps/api/directions/json",
                               mapView.myLocation.coordinate.latitude,
                               mapView.myLocation.coordinate.longitude,
                               7.0777802,
                               -96.7284766,@"AIzaSyDs703lLfydRw7Z0C-xqIbkV5Xydhl04ho"];
        NSURLSessionDataTask *directionsTask = [session dataTaskWithRequest: urlString
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *e) {
                                                                     if (!e) {
                                                                         
                                                                     }
                                                                 }];
    }*/
    /*
     GMSMutablePath *path = [GMSMutablePath path];
     [path addLatitude:-37.81319 longitude:144.96298];
     [path addLatitude:-31.95285 longitude:115.85734];
     GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
     polyline.strokeWidth = 10.f;
     polyline.geodesic = YES;
     polyline.map = mapView_;
     */
    
    NSLog(@"try");
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(mlatitude,mlongitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(17.0777802,-96.7284766)];
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.strokeWidth = 2.f;
    rectangle.map = mapView;
    self.viewMap=mapView;
    
    return YES;
}
- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    GMSGeocoder *gecoder=[GMSGeocoder geocoder];
    [gecoder reverseGeocodeCoordinate:coordinate completionHandler:^(GMSReverseGeocodeResponse *response, NSError *Error) {
        //
    }];
}



- (IBAction)btnMap:(id)sender {
  [self paintMap];
}
@end
