//
//  ResultViewController.h
//  Ambagan
//
//  Created by Kana on 11/30/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *reportType;
@property (weak, nonatomic) IBOutlet UITableView *resultTable;
@property (nonatomic) AppDelegate *ad;
@property (weak, nonatomic) IBOutlet UITableView *reportsTable;
@property (strong, nonatomic) NSMutableArray *reportList;
@end
