//
//  ConfirmationViewController.h
//  Electrodom
//
//  Created by Jacobo Singer on 27/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "SWRevealViewController.h"

@interface ConfirmationViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (strong, nonatomic)  Order *order;

@end
