//
//  CartViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 8/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Product.h"

@interface CartViewController : PFQueryTableViewController

@property (nonatomic, strong) Product *product;
@property (weak, nonatomic) IBOutlet UIButton *gabragge_button;

@end