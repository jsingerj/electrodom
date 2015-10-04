//
//  ViewController.m
//  Electrodom
//
//  Created by Juan Cambon on 26/9/15.
//  Copyright (c) 2015 Juan Cambon. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize user_name;
@synthesize password;
@synthesize activityIndicator;
- (void)viewDidLoad {
    self.user_name.delegate= self;
    self.password.delegate=self;

    
    [super viewDidLoad];
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator stopAnimating];
    
    
    
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logIn:(id)sender{
    if(! [self.activityIndicator isAnimating])
    {
        
        NSString * emailText= [self.user_name text];
        NSString * passwordText = [self.password text];
        
        if ([emailText length]==0 || [passwordText length]==0){
            UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Inicio sesión " message:@"Por favor complete la contraseña y el mail para ingresar " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [messageView show];
            return ;
            
        }
        
        //agregar chequeo si es valido el mail.
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidden:NO];
        
        [PFUser logInWithUsernameInBackground:emailText password:passwordText
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self showHome];
                                            } else {
                                                NSString *message = [error localizedDescription];
                                                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Nombre de usuario y su Contraseña son incorrectos" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                [alertView show];
                                                
                                            }
                                            [self.activityIndicator stopAnimating];
                                            [self.activityIndicator setHidden:YES];
                                            
                                        }];
        
    }
}


-(void)showHome{
    UINavigationController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationViewController"];
    [self presentViewController:viewController animated:YES completion:nil];}

@end
