//
//  LocationViewController.h
//  Ambagan
//
//  Created by Kana on 11/29/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SummaryViewController.h"
#import "CustomViewController.h"

@interface LocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *locationTable;
@property (nonatomic) AppDelegate *ad;
@property (nonatomic) NSMutableArray* locationList;
@property (strong, nonatomic) NSString* location;
- (IBAction)addNewLocation:(id)sender;
- (void)viewSummary;

@end
