//
//  RegisterViewController.m
//  Electrodom
//
//  Created by Juan Cambon on 27/9/15.
//  Copyright © 2015 Juan Cambon. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
//#import "MessageDictionary.m"

@interface RegisterViewController ()

@end

@implementation RegisterViewController


@synthesize username;
@synthesize last_name;
@synthesize password;
@synthesize name;
@synthesize repeat_password;
@synthesize ID;
@synthesize phone_number;
- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signUpPressed:(id)sender {

    
    PFUser *user = [PFUser user];
    user.username = username.text;
    user.password =password.text;
    user.email = username.text;
    
      // other fields can be set just like with PFObject
    user[@"name"] =name.text;
    user[@"last_name"] =last_name.text;
    user[@"document_number"] =ID.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *phone = [f numberFromString:phone_number.text];
    user[@"phone"] =phone;
    

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
        
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"OK" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];

            
            // Hooray! Let them use the app now.
        } else {
            
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            
            MessageDictionary * dictionary =[[MessageDictionary alloc]init];
            NSString * customMessage = [dictionary getMessage:errorString];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:customMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];

        }
    }];
    

    
    
  }


@end


