//
//  AmountViewController.m
//  Ambagan
//
//  Created by Kana on 11/29/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "AmountViewController.h"

@interface AmountViewController ()

@end

@implementation AmountViewController
@synthesize totalBill;
@synthesize splitType;
@synthesize type;
@synthesize definition;
@synthesize ad;
@synthesize serviceCharge;
@synthesize tip;
@synthesize discount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ad = [[UIApplication sharedApplication] delegate];

    if(ad.bill > 0){
        self.totalBill.text = [NSString stringWithFormat:@"%f", ad.bill];
    }
    
    if(ad.discount > 0){
        self.discount.text = [NSString stringWithFormat:@"%f", ad.discount];
    }
    
    if(ad.tip > 0){
        self.tip.text = [NSString stringWithFormat:@"%f", ad.tip];
    }
    
    if(ad.serviceCharge > 0){
        self.serviceCharge.text = [NSString stringWithFormat:@"%d",ad.serviceCharge];
    }
    [self.splitType setSelectedSegmentIndex:0];
    [self setType];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextViewController:(id)sender {
    if([self.totalBill.text length] > 0){

        ad.bill = [[NSDecimalNumber decimalNumberWithString: self.totalBill.text] doubleValue];
        
        if([self.serviceCharge.text length] > 0){
            ad.serviceCharge = [[self.serviceCharge.text stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
        } else {
            ad.serviceCharge = 0;
        }
        
        if([self.discount.text length] > 0){
            ad.discount = [[NSDecimalNumber decimalNumberWithString:self.discount.text] doubleValue];
        } else {
            ad.discount = 0;
        }
        
        if([self.tip.text length] > 0){
            ad.tip = [[NSDecimalNumber decimalNumberWithString:self.tip.text] doubleValue];
        } else {
            ad.tip = 0;
        }

        LocationViewController *locationViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"locationViewController"];
        [self presentViewController:locationViewController animated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You can't make ambag with an empty bill. Come on, seriously." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
    }
}

-(IBAction)changeSplitter:(id)sender{
    [self setType];
}

- (void) setType{
    NSString *def = [[NSString alloc] init];
    if(splitType.selectedSegmentIndex == 0){
        self.type = @"Equal";
        def = @"\tBeing the same in quantity, size, degree, or value. Add equal amounts of water and flour.\n\n\tsynonyms: identical, uniform, alike, like, the same, one and the same, equivalent, indistinguishable;";
        
    }
    if(splitType.selectedSegmentIndex == 1){
        self.type = @"Custom";
        def = @"\tAng kay Juan ay babayaran ni Juan. Ang kay Pedro ay babayaran ni Pedro.\n\n\tUnless manlilibre si Juan, okay lang yun.";
    }
    self.definition.text = def;
    ad.splitType = self.type;
}

#pragma UITextFieldDelegate

- (IBAction)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
}
@end
