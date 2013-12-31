//
//  ReportViewController.m
//  Ambagan
//
//  Created by Kana on 11/30/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController
@synthesize ad;
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
    ad.report_type = 0;
    //ad.report_date = 0;
    self.reportTime.selectedSegmentIndex = 0;
    self.list  = [[NSArray alloc] initWithObjects:@"Events", @"People (Ambagers)",@"Amount (Ambagan)",@"Places", nil];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.list count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.list objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen
{
    NSLog(@"Selected Row %d", row);
    ad.report_type = row;
}
- (IBAction)viewReport:(id)sender {
    ad.report_date = self.reportTime.selectedSegmentIndex;
}

- (IBAction)chooseViewController:(id)sender {
    /*if(ad.report_type == 0){
        AllEventsViewController *allEventsViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"allEventsViewController"];
        [self presentViewController:allEventsViewController animated:YES completion:nil];
    } else {*/
    ad.report_date = self.reportTime.selectedSegmentIndex;
    
        ResultViewController *resultViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"resultView"];
        [self presentViewController:resultViewController animated:YES completion:nil];
    //}

}
@end
