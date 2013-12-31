//
//  AmbagerViewController.h
//  Ambagan
//
//  Created by Kana on 11/27/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AppDelegate.h"
#import "AmountViewController.h"

@interface AmbagerViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *ambagerTable;
@property (strong, nonatomic) NSMutableArray *ambagerList;
@property (nonatomic) NSString *fullname;
@property (nonatomic) AppDelegate *ad;
- (IBAction)submitButton:(id)sender;
- (IBAction)addAmbager:(id)sender;
- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;

@end
