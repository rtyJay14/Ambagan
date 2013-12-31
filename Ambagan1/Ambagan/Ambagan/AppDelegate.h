//
//  AppDelegate.h
//  Ambagan
//
//  Created by Kana on 11/27/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) DataSource *ds;
@property (assign, nonatomic, readwrite) NSMutableArray *ambagers;
@property (assign, nonatomic, readwrite) double bill;
@property (assign, nonatomic, readwrite) NSString *location;
@property (assign, nonatomic, readwrite) NSString *splitType;
@property (assign, nonatomic, readwrite) int serviceCharge;
@property (assign, nonatomic, readwrite) double tip;
@property (assign, nonatomic, readwrite) double discount;
@property (assign, nonatomic, readwrite) int report_type;
@property (assign, nonatomic, readwrite) int report_date;
- (void) invalidateValues;
@end
