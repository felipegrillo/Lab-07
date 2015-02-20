//
//  listaViewController.m
//  Lab-07
//
//  Created by felipe on 18/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import "listaViewController.h"
#import "cellTableLista.h"
#import <Parse/Parse.h>

//NSArray *name1;
NSArray *myObjects;


@interface listaViewController ()

@end

@implementation listaViewController

- (void)viewDidLoad {
   [self imprimeData];
    [super viewDidLoad];
    [self performSelector:@selector(imprimeData)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return obj.count;
}



//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"cellOaxaca");
    static NSString *CellIdentifier = @"cellLista";
    
    cellTableLista *cell = (cellTableLista *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellTableLista  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    PFObject *tempObject=[obj objectAtIndex:indexPath.row];

    cell.lblNombre.text       =[tempObject objectForKey:@"Name"];
    
    return cell;
}

//-- Imprimiendo campos
- (void) imprimeData{
    PFQuery *query = [PFQuery queryWithClassName:@"Ubicacion"];
   
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            obj=[[NSArray alloc] initWithArray:objects];
            
        }
        [_tblView reloadData];
    }];
}



@end
