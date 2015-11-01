//
//  NFCViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 20/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "NFCViewController.h"
#import "Product.h"
#import "ProductDetailViewController.h"
#import "SWRevealViewController.h"

@implementation NFCViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scan_product"]) {
        PFQuery *query = [PFQuery queryWithClassName:@"Product"];
        Product *product = (Product *)[[query whereKey:@"objectId" equalTo:@"U271hoqquY"] getFirstObject];
        ProductDetailViewController *destViewController = segue.destinationViewController;
        product.brand = [product objectForKey:@"Marca"];
        product.promotion = [product objectForKey:@"promotionID"];
        product.categorie = [product objectForKey:@"CategoryId"];
        destViewController.product = product;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 //   _barButton.target = self.revealViewController;
 //   _barButton.action = @selector(revealToggle:);
    
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}


@end
