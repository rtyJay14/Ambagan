//
//  ViewController.m
//  Ambagan
//
//  Created by Kana on 11/27/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize ad;
- (void)viewDidLoad
{
    [super viewDidLoad];
    ad = [[UIApplication sharedApplication] delegate];
    [ad invalidateValues];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
