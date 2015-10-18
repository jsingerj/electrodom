//
//  ProductDetailViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "CartViewController.h"
@implementation ProductDetailViewController
@synthesize product_description;
@synthesize name;
@synthesize image;
@synthesize product;
@synthesize addProduct;
@synthesize description;
@synthesize product_brand;
@synthesize product_price;
@synthesize category;


@synthesize cart_button;


-(void)createTopBar {
    
    
    UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = leftButtonView.frame;
    [leftButton setImage:[UIImage imageNamed:@"shopping122.png"] forState:UIControlStateNormal];
    
    [leftButton setTitle:@"0" forState:UIControlStateNormal];
    leftButton.tintColor = [UIColor blueColor];
    leftButton.autoresizesSubviews = YES;
    leftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [leftButton addTarget:self action:@selector(goToCart:) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:leftButton];
    
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
    self.navigationItem.rightBarButtonItem = leftBarButton;
    
    
}
- (void)viewDidLoad {
    
    [self createTopBar];
    NSString *test = self.product.picture.url;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        UIImage* myImage =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:test]]];
        
        
        dispatch_sync(  dispatch_get_main_queue(), ^(void) {
            [image setImage:myImage];        });
    });
    
    name.text = product.name;
    product_description.text = [product objectForKey:@"description"];
    long price  = product.price;
    
    
    NSString *strFromInt = [[NSNumber numberWithLong:price] stringValue];
    
    NSString *str = [NSString stringWithFormat: @"%@ %@", @"$", strFromInt];
    product_price.text = str;
    product_brand.text = self.product.brand;
  //  category.text = [product objectForKey:@"CategoryId"];
    
    [super viewDidLoad];
    
    
}


-(IBAction)goToCart:(id)sender {
    
    CartViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
    [self.navigationController pushViewController:viewController animated:YES ];
}



- (IBAction)addProductToCart:(id)sender {
    [self.product pin];
    
    
   // [leftButton setTitle:@"0" forState:UIControlStateNormal]; actualizar el el dato de la cantidad de productos
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
