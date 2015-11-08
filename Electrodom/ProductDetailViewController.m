//
//  ProductDetailViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "CartViewController.h"
#import "GlobalElectrodom.h"

@interface ProductDetailViewController()

@property (nonatomic, strong) NSArray *results;
@end

@implementation ProductDetailViewController
@synthesize product_description;
@synthesize name;
@synthesize image;
@synthesize product;
@synthesize description;
@synthesize product_brand;
@synthesize product_price;
//@synthesize category;
@synthesize promotion_Price;
@synthesize discount;
@synthesize line;
@synthesize rightButton;





-(void)setTotalProducts{
    GlobalElectrodom * instance = [GlobalElectrodom getInstance];
    int total = [instance getTotalProducts];
    NSString * totalProductsString =[NSString stringWithFormat:@"%d",total];
    [rightButton setTitle: totalProductsString forState:UIControlStateNormal];
}

-(void)createTopBar {
    
    
    UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
   rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.backgroundColor = [UIColor clearColor];
    rightButton.frame = leftButtonView.frame;
    [rightButton setImage:[UIImage imageNamed:@"shopping122.png"] forState:UIControlStateNormal];
    [self setTotalProducts];
    rightButton.tintColor = [UIColor blueColor];
    rightButton.autoresizesSubviews = YES;
    rightButton.tag=120;
    rightButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [rightButton addTarget:self action:@selector(goToCart:) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:rightButton];
    
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
    product_brand.text = self.product.Marca;
    
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
    
    
    
    
    
    [self.tableView reloadData];
    
    [super viewDidLoad];
    
}


-(IBAction)goToCart:(id)sender {
    
    CartViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
    [self.navigationController pushViewController:viewController animated:YES ];
}



- (IBAction)addProductToCart:(id)sender {
    self.product.quantity = 1;
   [[GlobalElectrodom getInstance]addProduct:self.product];
    [self setTotalProducts];
   //[leftButton setTitle:@"0" forState:UIControlStateNormal]; actualizar el el dato de la cantidad de productos
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query whereKeyExists:@"promotionID"];
    NSLog(@"error: %@",product);

    [query whereKey:@"CategoryId" equalTo:product.CategoryId];
    [query whereKey:@"objectId" notEqualTo:product.objectId];
    self.results = [query findObjects];
    
    return self.results.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *prod = self.results[indexPath.row];
    
    static NSString *simpleTableIdentifier = @"RelatedArticleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    PFFile *thumbnail = prod.picture;
    UIImageView* cardImage = (UIImageView*)[cell viewWithTag:100];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        UIImage* myImage =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnail.url]]];
        
        
        dispatch_sync(  dispatch_get_main_queue(), ^(void) {
            [cardImage setImage:myImage];        });
    });
    
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = prod.name;
    
    UILabel *brandLabel = (UILabel*) [cell viewWithTag:102];
    NSString *brand =  prod.Marca;
    brandLabel.text = brand;
    
    UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:103];
    long  price = prod.price;
    NSString *strFromInt = [[NSNumber numberWithLong:price] stringValue];
    prepTimeLabel.text = [NSString stringWithFormat: @"%@ %@", @"$", strFromInt]; ;
    
    return cell;
    
}



@end
