//
//  ResultViewController.m
//  Ambagan
//
//  Created by Kana on 11/30/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize ad;
@synthesize reportList;
@synthesize reportsTable;

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
    ad = [[UIApplication sharedApplication] delegate];
    NSString *r_type = [[NSString alloc] init];
    NSString *r_date = [[NSString alloc] init];
    
    NSLog(@"ad.report_date: %d", ad.report_date);
    NSLog(@"ad.report_type: %d", ad.report_type);
    //UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 12.0 ];
    //reportsTable.font  = myFont;
    
    switch(ad.report_type){
        case 0: // event
            r_type = @"Event";
            //reportList = [ad.ds getEventByDate: ad.report_date];
            reportList = [[self.ad.ds getEventsByDate: self.ad.report_date] objectAtIndex:1];
            break;
        case 1: // people
            r_type = @"People";
            reportList = [ad.ds getPeopleByDate: ad.report_date];
            break;
        case 2: // amount
            r_type = @"Amount";
            reportList = [ad.ds getGastosByDate : ad.report_date];
            break;
        case 3: // places
            r_type = @"Places";
            reportList = [ad.ds getPlaceByDate: ad.report_date];
            break;
        default:
            reportList = [[self.ad.ds getEventsByDate: self.ad.report_date] objectAtIndex:1];
            break;
    }
    
    switch(ad.report_date){
        case 0: // daily
            r_date = @"Daily";
            break;
        case 1: // weekly
            r_date = @"Weekly";
            break;
        case 2: // monthly
            r_date = @"Monthly";
            break;
        case 3: // yearly
            r_date = @"Yearly";
            break;
        default:
            r_date = @"Daily";
            break;
    }
    //NSString * strRR = [NSString stringWithFormat:@"%@%@%@", fileName, str, extension];
    self.reportType.text = [NSString stringWithFormat:@"Your %@ %@", r_date, r_type];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.textColor=[UIColor blackColor];
    //cell.detailTextLabel.font=[UIFont fontWithName:@"Helvetica" size:12.0];
    cell.detailTextLabel.textColor=[UIColor blackColor];
    cell.textLabel.font=[UIFont fontWithName:@"Helvetica" size:14.0];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
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
    return [self.reportList count];
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
    
    cell.textLabel.text = [reportList objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.reportList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
@end
