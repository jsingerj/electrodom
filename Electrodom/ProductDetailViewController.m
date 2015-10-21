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
@synthesize description;
@synthesize product_brand;
@synthesize product_price;
@synthesize category;
@synthesize promotion_Price;
@synthesize discount;
@synthesize line;



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
    
    if(product.promotion!=nil){
        NSString *idProm = product.promotion.objectId;
        PFQuery *quer = [PFQuery queryWithClassName:@"Promotion"];
        Promotion *prom = (Promotion *)[[quer whereKey:@"objectId" equalTo:idProm] getFirstObject];
        long disc = [[prom objectForKey:@"Discount"]longValue];
        
        
        float x = 1 - ((float)disc/100);
        long finalPrice = price * x ;
        NSString *realP = [[NSNumber numberWithLong:finalPrice] stringValue];
        NSString *coin = @"$";
        NSString *total = [NSString stringWithFormat: @"%@ %@", coin, realP];
        promotion_Price.text = total ;
        NSString *d = [[NSNumber numberWithLong:disc] stringValue];;
        NSString *finaldisc = [NSString stringWithFormat: @"%@ %@", @"%", d];
        discount.text = finaldisc;
        
    }
    
    else
    {
        line.text=@"";
        promotion_Price.text=@"";
        discount.text = @"";
        
    }
    

    
    
  //  category.text = [product objectForKey:@"CategoryId"];
    
    [super viewDidLoad];
    
    
}


-(IBAction)goToCart:(id)sender {
    
    CartViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
    [self.navigationController pushViewController:viewController animated:YES ];
}



- (IBAction)addProductToCart:(id)sender {
    self.product.quantity = 1;
    [self.product pin];
    
    
    
   // [leftButton setTitle:@"0" forState:UIControlStateNormal]; actualizar el el dato de la cantidad de productos
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
