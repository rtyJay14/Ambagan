//
//  CustomViewController.m
//  Ambagan
//
//  Created by Kana on 12/1/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController
@synthesize ad;
@synthesize people;
@synthesize sum;
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
    NSLog(@"CustomViewController viewDidLoad");
    sum = 0;

    ad = [[UIApplication sharedApplication] delegate];
    people = ad.ambagers;
    self.locationLabel.text = ad.location;
   
    double _bill = (ad.bill + (ad.bill * (ad.serviceCharge * .01)) - ad.discount + ad.tip);
    self.billLabel.text = [NSString stringWithFormat:@"%.2f", _bill];
    self.kulangLabel.text = [NSString stringWithFormat:@"%.2f", _bill];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 170, self.view.frame.size.width, 210)];
    NSInteger viewcount= 4;
    
    for(int i = 0; i < [people count]; i++){
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(150, i*30, 120, 25)];
        textField.tag = i + 1;
        textField.returnKeyType = UIReturnKeyDone;
        //textField.
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        textField.placeholder = @"Ambag to give";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.adjustsFontSizeToFitWidth = TRUE;
        [textField addTarget:self
                      action:@selector(textFieldDone:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
        [scrollview addSubview:textField];
        
        UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, i*30, 120, 25)];
        headingLabel.text = [people objectAtIndex:i];
        //headingLabel.tag = i;
        [scrollview addSubview:headingLabel];
    }
    
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *viewcount);
    [self.view addSubview:scrollview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //UILabel *ballNummer = (UILabel*)[self.view viewWithTag:nummer];
    int temp = sum + [textField.text intValue];
    sum = temp;

    NSLog(@"naedit yung %d", textField.tag);
    NSLog(@"Sum: %d", self.sum);
    self.amountLabel.text = [NSString stringWithFormat:@"%d", sum];
    self.kulangLabel.text = [NSString stringWithFormat:@"%d", [self.billLabel.text intValue]-sum];
    return true;
    
}

-(BOOL) textFieldShouldStartEditing:(UITextField *)textField{
    if([textField hasText]){
        int temp = [textField.text intValue];
        sum = sum - temp;
    }
    
    NSLog(@"Sum: %d", self.sum);
    return true;
}
-(IBAction)saveEvent:(id)sender{
    
    if([self.kulangLabel.text intValue] == 0){
        int location_id = [ad.ds getLocationId:ad.location];
        [ad.ds insertEvent: location_id:ad.bill];
        int event_id = [ad.ds getEventId];
        
        for(int i = 0; i < [people count]; i++){
            /*
             for(int i = 0; i < [people count]; i++){
             UITextField *textField = (UITextField*)[self.view viewWithTag:i+1];
             NSString *fieldValue = textField.text;
             NSLog(@"Field %d has value: %@", i, fieldValue);

             */
            UITextField *ui = (UITextField *) [self.view viewWithTag:i+1];
            int ambager_id = [ad.ds getAmbagerId:[people objectAtIndex:i]];
            NSLog(@"amount: %d", [ui.text intValue]);
            [ad.ds insertAmbagan:event_id :ambager_id : [ui.text intValue]];
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"The ambagan transaction has been saved. View reports for more information." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
        
        ViewController *viewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
        [self presentViewController:viewController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Kulang Pa" message:@"The ambagan is kulang pa. Mag abono ka na!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        alert.tag = 2;
        [alert show];
    }
    

}

- (IBAction)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}


#pragma UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSIndexPath *selectedIndexPath = [ambagerTable indexPathForSelectedRow];
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    switch(alertView.tag){
        case 1:
            if([title isEqualToString:@"Okay"]){
                
            }
            break;
        case 2:
            break;
        default:
            break;
    }
    
}
@end
