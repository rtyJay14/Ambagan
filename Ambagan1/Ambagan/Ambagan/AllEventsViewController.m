//
//  AllEventsViewController.m
//  Ambagan
//
//  Created by Kana on 12/1/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "AllEventsViewController.h"

@interface AllEventsViewController ()

@end

@implementation AllEventsViewController
@synthesize list;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ad = [[UIApplication sharedApplication] delegate];
    list = [[NSArray alloc] init];
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
    [self loadEvents];
    
}

-(void) loadEvents{
    NSLog(@"loadEvents");
    //[self.ad.ds test];
    
    list = [[self.ad.ds getEventsByDate: self.ad.report_date] objectAtIndex:1];
    //NSLog(@"%i", [allPlaces count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
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
    
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //- (NSIndexPath *)indexPathForSelectedRow
    //NSLog(@"%@", [tableView ][tableView indexPathsForSelectedRows]);
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    //location = selectedCell.textLabel.text;
    //ad.location = self.location;
    //[self viewSummary];
}

@end
