//
//  AmountViewController.h
//  Ambagan
//
//  Created by Kana on 11/29/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"
#import "AppDelegate.h"

@interface AmountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *serviceCharge;
@property (weak, nonatomic) IBOutlet UITextField *tip;
@property (weak, nonatomic) IBOutlet UITextField *discount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *splitType;
@property (weak, nonatomic) IBOutlet UITextField *totalBill;
@property (weak, nonatomic) IBOutlet UITextView *definition;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) AppDelegate* ad;
- (IBAction)nextViewController:(id)sender;
- (IBAction)changeSplitter:(id)sender;
- (IBAction)textFieldShouldReturn:(UITextField *)textField;
@end
