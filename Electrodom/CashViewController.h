//
//  CashViewController.h
//  Electrodom
//
//  Created by Jacobo Singer on 31/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashOrder.h"
@interface CashViewController : UIViewController

@property (strong, nonatomic)  CashOrder *cashOrder;

@property (weak, nonatomic) IBOutlet UILabel *orderId;

@end
