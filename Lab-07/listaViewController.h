//
//  listaViewController.h
//  Lab-07
//
//  Created by felipe on 18/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface listaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    NSArray *obj;
}
@property (strong, nonatomic) IBOutlet UITableView *tblView;


@end
