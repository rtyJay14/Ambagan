//
//  LocationViewController.m
//  Ambagan
//
//  Created by Kana on 11/29/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize ad;
@synthesize locationList;
@synthesize locationTable;
@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //((SummaryViewController*)self.view).samp = @"huwat";
    self.ad = [[UIApplication sharedApplication] delegate];    
    [self loadLocations];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadLocations{
    NSLog(@"loadLocations");
    //[self.ad.ds test];
    locationList = [[NSMutableArray alloc] init];
    NSMutableArray *allPlaces = [self.ad.ds getAllLocations];
    //NSLog(@"%i", [allPlaces count]);

    for(int i = 0; i < [allPlaces count]; i++){
        NSString *temp = (NSString *) [allPlaces objectAtIndex:i];
        [locationList addObject:temp];
    }
    [locationTable reloadData];    
}
- (IBAction)addNewLocation:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Location" message:@"Type in the name of the location." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 0;
    [alert show];
}

- (void)viewSummary {
    //[self.locationList ]
    if([ad.splitType isEqualToString:@"Equal"]){
        SummaryViewController *summaryViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"summaryViewController"];
        [self presentViewController:summaryViewController animated:YES completion:nil];
    } else {
        CustomViewController *customViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"customViewController"];
        [self presentViewController:customViewController animated:YES completion:nil];
    }


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.locationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
		[cell addGestureRecognizer:longPressGesture];
    }
    
    cell.textLabel.text = [locationList objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //- (NSIndexPath *)indexPathForSelectedRow
    //NSLog(@"%@", [tableView ][tableView indexPathsForSelectedRows]);
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    location = selectedCell.textLabel.text;
    ad.location = self.location;
    [self viewSummary];
}
    

#pragma UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(alertView.tag){
        case 0:
            if(buttonIndex == 1){
                NSString *location = [[alertView textFieldAtIndex:0] text];
                //[self.locationList addObject:location];
                [self.ad.ds insertLocation:location];
            }
            [self loadLocations];
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
    
}
@end
