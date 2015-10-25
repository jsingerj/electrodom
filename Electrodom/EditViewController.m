//
//  EditViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 3/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import "EditViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
@implementation EditViewController

@synthesize username;
@synthesize last_name;
@synthesize password;
@synthesize name;
@synthesize repeat_password;
@synthesize ID;
@synthesize phone;
@synthesize change_password;




- (void)viewDidLoad {
    PFUser *user =    [PFUser currentUser];
    self.last_name.text=[user objectForKey:@"last_name"];
    self.name.text =[user objectForKey:@"name"];
    self.ID.text =[user objectForKey:@"document_number"];
    long  phone = [[user objectForKey:@"phone"] longValue];
    NSString *strFromInt = [[NSNumber numberWithLong:phone] stringValue];
    self.phone.text=strFromInt;
    self.username.text= [user username];
    // Do any additional setup after loading the view, typically from a nib.
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
      [super viewDidLoad];
    
    

    

}


- (IBAction)updateUser:(id)sender {
   

    if(name.text.length==0 || last_name.text.length==0 || phone.text==0 ||  username.text.length==0 || ID.text==0)
    {
        UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Editar perfil " message:@"Por favor complete todos los datos para actualizar " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageView show];
        return ;
    }
    else
    {
        if (change_password.text.length<6 && change_password.text.length>0) {
            UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Editar perfil " message:@"La contraseña debe de ser de al menos 6 caracteres." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [messageView show];
            change_password.text = @"";
            repeat_password.text=@"";
            return ;
        }
        else
        {
            if( change_password.text != repeat_password.text && change_password.text.length>0)
            {
                UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Editar perfil " message:@"La nueva contraseña y repetir contraseña no coinciden ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [messageView show];
                change_password.text = @"";
                repeat_password.text=@"";
                return ;
            }
            else
            {
                if(ID.text.length>8 || ID.text.length<6)
                {
                    UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Editar perfil " message:@"Cédula de identidad inválida ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [messageView show];
                    ID.text = @"";
                    return ;
                    
                }
                else
                {
                    NSString *pass = password.text;
                    PFUser *user =    [PFUser currentUser];
                    NSString *oldPass=[user password];
                    //password con contrasena actual de la base
                    if(pass!=oldPass && password.text.length>0)
                    {
                        UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Editar perfil " message:@"La contraseña no coincide con la contraseña actual. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [messageView show];
                        self.password.text = @"";
                        return ;
                        
                    }
                    else
                    {
                    @try
                    {
                        PFUser *user = [PFUser currentUser];
                        user.username = username.text;
                        if(change_password.text.length>0)
                            user.password =change_password.text;
                        user.email = username.text;
                        
                        // other fields can be set just like with PFObject
                        user[@"name"] =name.text;
                        user[@"last_name"] =last_name.text;
                        user[@"document_number"] =ID.text;
                        
                        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                        f.numberStyle = NSNumberFormatterDecimalStyle;
                        NSNumber *phonenumer = [f numberFromString:phone.text];
                        user[@"phone"] =phonenumer;
                        
                        
                        
                        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (!error) {
          
                                
                                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Se han actualizado los datos correctamente" message:@"OK" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                [alertView show];
                                
                                
                                
                                // Hooray! Let them use the app now.
                            } else {
                                
                                NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                                
                                MessageDictionary * dictionary =[[MessageDictionary alloc]init];
                                NSString * customMessage = [dictionary getMessage:errorString];
                                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:customMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                [alertView show];
                                [super viewDidLoad];
                                
                            }
                        }];
                        
                        
                    }
                    @catch (NSException* e) {
                        UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Registro " message:@"Numero teléfono inválido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [messageView show];
                        phone.text = @"";
                        return ;
                  }
                    }
                    
                }
                
            }
            
            
        }
    }

}

- (IBAction)logOut:(id)sender {
    if ([PFUser currentUser]) {
        [PFUser logOut];
    }
    
}


@end




