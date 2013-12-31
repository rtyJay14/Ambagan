//
//  SummaryViewController.m
//  Ambagan
//
//  Created by Kana on 11/28/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "SummaryViewController.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController
@synthesize totalAmountPaid;
@synthesize kulangPa;
@synthesize ad;
@synthesize ambagerList;
@synthesize ambagerTable;
@synthesize ambagPerPerson;
@synthesize ambagPerPersonLabel;
@synthesize location;
@synthesize _ambagPerPerson;

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
    
    NSLog(@"SummaryViewController viewDidLoad");
    ambagerList = [[NSMutableArray alloc] init];
    ad = [[UIApplication sharedApplication] delegate];
    ambagerList = ad.ambagers;
    self.location.text = ad.location;
    
    int numOfPeople = [ambagerList count];
    double _bill = (ad.bill + (ad.bill * (ad.serviceCharge * .01)) - ad.discount + ad.tip);
    ad.bill = _bill;
    NSLog(@"servicecharge: %f", ad.serviceCharge * .01);
    if([ad.splitType isEqualToString:@"Equal"]){
        [ambagPerPerson setHidden:FALSE];
        [ambagPerPersonLabel setHidden:FALSE];
        
        _ambagPerPerson = (_bill / numOfPeople);
        NSLog(@"_bill: %f", _bill);
        NSLog(@"ad.tip: %f", ad.tip);
        NSLog(@"ad.discount: %f", ad.discount);
        NSLog(@"numOfPeople: %d", numOfPeople);
        
        ambagPerPerson.text = [NSString stringWithFormat:@"%.2f",_ambagPerPerson];
    }

    self.totalBill.text = [NSString stringWithFormat:@"%.2f", _bill];
    
    //[self loadAmbagers];
    [ambagerTable reloadData];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveEvent:(id)sender{
    int location_id = [ad.ds getLocationId:ad.location];
    [ad.ds insertEvent: location_id:ad.bill];
    int event_id = [ad.ds getEventId];
    for(int i = 0; i < [ambagerList count]; i++){
        int ambager_id = [ad.ds getAmbagerId:[ambagerList objectAtIndex:i]];
        [ad.ds insertAmbagan:event_id :ambager_id : _ambagPerPerson];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"The ambagan transaction has been saved. View reports for more information." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    alert.tag = 1;
    [alert show];
    
    ViewController *viewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) numberOfColumnsOfGridView:(UITableView *) grid
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.ambagerList count];
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
    
    cell.textLabel.text = [ambagerList objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.ambagerList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSIndexPath *selectedIndexPath = [ambagerTable indexPathForSelectedRow];
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    switch(alertView.tag){
        case 1:
            if([title isEqualToString:@"Okay"]){
                
            }
            break;
        case 2:
            break;
        default:
            break;
    }
    
}

@end
