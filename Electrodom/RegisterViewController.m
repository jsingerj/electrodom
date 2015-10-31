//
//  RegisterViewController.m
//  Electrodom
//
//  Created by Juan Cambon on 27/9/15.
//  Copyright © 2015 Juan Cambon. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
#import "ProductViewController.h"
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
- (IBAction)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}


- (IBAction)signUpPressed:(id)sender {

    
    
    if(name.text.length==0 || last_name.text.length==0 || phone_number.text==0 || password.text==0 || repeat_password.text==0 || username.text.length==0 || ID.text==0)
    {
        UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Registro " message:@"Por favor complete todos los campos para registrarse " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageView show];
        return ;
    }
    else
    {
        if (password.text.length<6) {
            UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Registro " message:@"La contraseña debe de ser de al menos 6 caracteres." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [messageView show];
            password.text = @"";
            repeat_password.text=@"";
            return ;
        }
        else
        {
            if(password.text != repeat_password.text)
            {
                UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Registro " message:@"Las contraseñas no coinciden ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [messageView show];
                password.text = @"";
                repeat_password.text=@"";
                return ;
            }
            else
            {
                 if(ID.text.length>8 || ID.text.length<6)
                 {
                     UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Registro " message:@"Cédula de identidad inválida ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [messageView show];
                     ID.text = @"";
                     return ;
                     
                 }
                else
                {
                    @try
                    {
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
                                
                                
                                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Registro" message:@"Se ha registrado exitosamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
                    @catch (NSException* e) {
                        UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Registro " message:@"Numero teléfono inválido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [messageView show];
                        phone_number.text = @"";
                        return ;
                    }
                   
                }
                
            }

            
        }
    }
}


@end


