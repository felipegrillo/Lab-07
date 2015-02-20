//
//  ViewController.h
//  Lab-07
//
//  Created by felipe on 18/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import <iAd/iAd.h>
@interface Home : GAITrackedViewController <UIApplicationDelegate,ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgRestaunt;
@property (strong, nonatomic) IBOutlet UIButton *btnLista;
@property (strong, nonatomic) IBOutlet UIButton *btnMapa;

- (IBAction)showMapa:(id)sender;
- (IBAction)showLista:(id)sender;


@end

