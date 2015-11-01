//
//  EditViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 3/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "GlobalElectrodom.h"
#import "MessageDictionary.h"

@interface EditViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *last_name;
@property (weak, nonatomic) IBOutlet UITextField *ID;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *repeat_password;
@property (weak, nonatomic) IBOutlet UITextField *change_password;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
