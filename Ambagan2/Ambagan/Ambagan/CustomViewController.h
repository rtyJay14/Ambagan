//
//  CustomViewController.h
//  Ambagan
//
//  Created by Kana on 12/1/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
@interface CustomViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *kulangLabel;
@property (nonatomic) AppDelegate *ad;
@property (nonatomic) NSMutableArray *people;
@property (nonatomic) int sum;
-(IBAction)saveEvent:(id)sender;
@end
