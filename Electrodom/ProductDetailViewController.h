//
//  ProductDetailViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic, strong) Product *product;


@end
