//
//  AmbagerViewController.m
//  Ambagan
//
//  Created by Kana on 11/27/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "AmbagerViewController.h"

@interface AmbagerViewController ()

@end

@implementation AmbagerViewController

@synthesize ambagerTable;
@synthesize ambagerList;
@synthesize fullname;
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
    ambagerList = [[NSMutableArray alloc] init];
    ad = [[UIApplication sharedApplication] delegate];
    
    if([ad.ambagers count] > 0){
        self.ambagerList = ad.ambagers;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)displayPerson:(ABRecordRef)person
{
    
    NSString* fname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    self.fullname = [NSString stringWithFormat:@"%@ %@", fname, lname];

    [self.ambagerList addObject:self.fullname];
    ad.ambagers = self.ambagerList;
    [ambagerTable reloadData];
}


- (IBAction)submitButton:(id)sender {
    
    if([self.ambagerList count] < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You can't make ambag with only one or zero person involved. Add more ambagers." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
    } else {
        NSMutableArray *allUsers = [self.ad.ds getAllAmbager];
        //if ([myString1 caseInsensitiveCompare:myString2] == NSOrderedSame)
        NSLog(@"count: %d", [self.ambagerList count]);
        for(int i = 0; i < [self.ambagerList count]; i++){
            
            if([allUsers containsObject: [self.ambagerList objectAtIndex:i]]){
            //don't save sa dbase
                NSLog(@"Meron na, %@",[self.ambagerList objectAtIndex:i]);
            } else {
                [self.ad.ds insertAmbager:[self.ambagerList objectAtIndex:i]];
                NSLog(@"Insert, %@",[self.ambagerList objectAtIndex:i]);
            }
        }
        AmountViewController *amountViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"amountViewController"];
        [self presentViewController:amountViewController animated:YES completion:nil];
        
    }

}

- (IBAction)addAmbager:(id)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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


- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		UITableViewCell *cell = (UITableViewCell *)[gesture view];

		NSIndexPath *indexPath = [self.ambagerTable indexPathForCell:cell];

        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remove Person" message:@"Are you sure you want to remove this person from the list?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
        //alert.tag = 1;
        //[alert show];
	}
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
