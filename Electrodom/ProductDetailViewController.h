//
//  ProductDetailViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import <ParseUI/ParseUI.h>

@interface ProductDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cart_button;
@property (weak, nonatomic) IBOutlet UILabel *product_price;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *product_description;
@property (weak, nonatomic) IBOutlet UILabel *product_brand;

@property (weak, nonatomic) IBOutlet UILabel *category;

@property (weak, nonatomic) IBOutlet UIButton *addProduct;

@property (weak, nonatomic) IBOutlet UIImageView *imageCart;

@property (nonatomic, strong) Product *product;



@end
