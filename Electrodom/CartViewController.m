//
//  CartViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 8/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "CartViewController.h"
#import "ProductViewCell.h"
#import "Product.h"
#import "SWRevealViewController.h"
#import  "OrderViewController.h"
@interface CartViewController ()


@end


@implementation CartViewController

@synthesize total_amount;
@synthesize amount;




- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Product";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    UIBarButtonItem *btnBuy = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(buy:)];
    UIBarButtonItem *btnRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    UIBarButtonItem *btnMenu = [[UIBarButtonItem alloc] initWithImage:nil style:(UIBarButtonItemStylePlain) target:(self.revealViewController) action:(@selector(revealToggle:))];
    btnMenu.title=@"Menu";
    
    
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnBuy, btnRefresh,self.garbage, btnMenu,nil]];
    
    
}





- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query fromLocalDatastore];
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (ProductViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(Product *)product
{
    static NSString *simpleTableIdentifier = @"ProductCell";
    
    ProductViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[ProductViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
           // Configure the cell
    PFFile *thumbnail = [product picture];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //  thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    cell.product = product;
    cell.product_name.text = [product name];
    cell.product_brand.text = [product brand];
    int quantiy = product.quantity;
    cell.quantity.text = [NSString stringWithFormat:@"%d",quantiy];
    UILabel *prepTimeLabel = cell.total_price;
    long price = product.price;
    if(product.promotion!=nil)
    {
        NSString *idProm = product.promotion.objectId;
        PFQuery *quer = [PFQuery queryWithClassName:@"Promotion"];
        Promotion *prom = (Promotion *)[[quer whereKey:@"objectId" equalTo:idProm] getFirstObject];
        long disc = [[prom objectForKey:@"Discount"]longValue];
        float x = 1 - ((float)disc/100);
        price = price * x ;
    }
    
    NSString *varyingString1 = @"$";
    NSString *varyingString2 =[[NSNumber numberWithLong:(price * quantiy)] stringValue];
     NSString *str = [NSString stringWithFormat: @"%@ %@", varyingString1, varyingString2];
    prepTimeLabel.text=str;
    [cell.stepper setValue:quantiy];
    amount= amount + product.quantity * price;
    NSString *tot = [[NSNumber numberWithLong:amount] stringValue];
    total_amount.text  = [NSString stringWithFormat: @"%@ %@", @"$", tot];
    return cell;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}
- (IBAction)valueChanged:(UIStepper *)sender {
    double value = [sender value];
    ProductViewCell* cell =  (ProductViewCell*)[[sender superview]superview];
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:value];
    cell.quantity.text=[myDoubleNumber stringValue];
    
    Product *product = cell.product;
   
    long price = product.price;
    
    if(product.promotion!=nil)
    {
        NSString *idProm = product.promotion.objectId;
        PFQuery *quer = [PFQuery queryWithClassName:@"Promotion"];
        Promotion *prom = (Promotion *)[[quer whereKey:@"objectId" equalTo:idProm] getFirstObject];
        long disc = [[prom objectForKey:@"Discount"]longValue];
        float x = 1 - ((float)disc/100);
        price = price * x ;
    }

    long priceQ = price * value;
    
    NSString *varyingString1 = @"$";
    NSString *varyingString2 = [[NSNumber numberWithDouble:priceQ] stringValue];;
    NSString *str = [NSString stringWithFormat: @"%@ %@", varyingString1, varyingString2];
    cell.total_price.text = str;
    amount = amount -  (price * product.quantity  )  + priceQ;
    NSString *tot = [[NSNumber numberWithLong:amount] stringValue];
    total_amount.text  = [NSString stringWithFormat: @"%@ %@", @"$", tot];
    product.quantity=value;
    [product pin];
    
  }


-(void)calculateAmounts
{
    
    
}

- (IBAction)deleteItem:(id)sender {
    ProductViewCell* cell =  (ProductViewCell*)[[sender superview]superview];
    Product *product = cell.product;
   // amount = amount - (product.quantity * product.price);*/
    //no habria que hacer eso porque al recargar los objetos se hace la cuenta bien
    
  /*  PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query fromLocalDatastore];
    [[query getObjectInBackgroundWithId:product.objectId] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            // Something went wrong.
            return task;
        }
        
        Product *p = task;
        [p unpinInBackground];
        return task;
    }];*/
    
    [product unpin];
    amount = amount - (product.quantity * product.price);
    NSString *tot = [[NSNumber numberWithLong:amount] stringValue];
    total_amount.text  = [NSString stringWithFormat: @"%@ %@", @"$", tot];

    [self loadObjects];
    [self.tableView reloadData];
    
    
}
- (IBAction)delete_Cart:(id)sender {
    [Product unpinAllObjects];
    amount = 0;
    NSString *tot = [[NSNumber numberWithLong:amount] stringValue];
    total_amount.text  = [NSString stringWithFormat: @"%@ %@", @"$", tot];
    [self loadObjects];
    

}


- (IBAction)buy:(id)sender {
    
    OrderViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
    [self.navigationController pushViewController:toViewController animated:YES ];
    
    //  [self presentViewController:toViewController animated:YES completion:NULL];
}

- (IBAction)refresh:(id)sender {
    /* ProductViewCell* cell =  (ProductViewCell*)[[sender superview]superview];
     Product *product = cell.product;
     amount = amount - (product.quantity * product.price);*/
    //no habria que hacer eso porque al recargar los objetos se hace la cuenta bien
    [self loadObjects];
    
    
}



@end