//
//  AmbaganCell.m
//  Ambagan
//
//  Created by Kana on 11/27/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "AmbaganCell.h"

@implementation AmbaganCell
@synthesize ambaganList;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
