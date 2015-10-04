//
//  RegisterViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 27/9/15.
//  Copyright © 2015 Juan Cambon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalElectrodom.h"
#import "MessageDictionary.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *last_name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repeat_password;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *ID;
@property (weak, nonatomic) IBOutlet UITextField *phone_number;

@end
