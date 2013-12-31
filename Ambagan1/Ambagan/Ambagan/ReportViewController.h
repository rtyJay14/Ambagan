//
//  ReportViewController.h
//  Ambagan
//
//  Created by Kana on 11/30/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AllEventsViewController.h"
#import "ResultViewController.h"

@interface ReportViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *reportPicker;
@property (strong, nonatomic) NSArray* list;
- (IBAction)viewReport:(id)sender;
- (IBAction)chooseViewController:(id)sender;
@property (nonatomic) AppDelegate *ad;
@property (weak, nonatomic) IBOutlet UISegmentedControl *reportTime;
@property (assign, nonatomic, readwrite) IBOutlet UILabel *input;
@end
