//
//  LocationViewController.h
//  Ambagan
//
//  Created by Kana on 11/28/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UITableViewController
@property (nonatomic, strong) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) NSArray *locations;
@end
