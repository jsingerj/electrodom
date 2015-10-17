//
//  ProductViewCell.h
//  Electrodom
//
//  Created by Juan Cambón on 14/10/15.


#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductViewCell : UITableViewCell

@property (strong, nonatomic) Product *product;
@property (weak, nonatomic) IBOutlet UIView *image;
@property (weak, nonatomic) IBOutlet UILabel *product_brand;
@property (weak, nonatomic) IBOutlet UILabel *total_price;
@property (weak, nonatomic) IBOutlet UILabel *quantity;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@end
