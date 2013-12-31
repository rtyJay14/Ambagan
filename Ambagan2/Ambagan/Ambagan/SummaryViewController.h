//
//  SummaryViewController.h
//  Ambagan
//
//  Created by Kana on 11/28/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
@interface SummaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountPaid;
@property (weak, nonatomic) IBOutlet UILabel *kulangPa;
@property (weak, nonatomic) IBOutlet UITableView *ambagerTable;
@property (nonatomic) AppDelegate *ad;
@property (weak, nonatomic) IBOutlet UILabel *ambaganLocation;
@property (weak, nonatomic) IBOutlet UILabel *ambagPerPerson;
@property (weak, nonatomic) IBOutlet UILabel *ambagPerPersonLabel;
@property (nonatomic) NSMutableArray *ambagerList;
@property (weak, nonatomic) IBOutlet UILabel *totalBill;
@property (nonatomic) double _ambagPerPerson;
-(IBAction)saveEvent:(id)sender;
@end
