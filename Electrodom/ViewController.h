//
//  ViewController.h
//  Electrodom
//
//  Created by Jacobo Singer on 26/9/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalElectrodom.h"
@interface ViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *user_name;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)logIn:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

