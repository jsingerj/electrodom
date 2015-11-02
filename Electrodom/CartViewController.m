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
    UIBarButtonItem *btnBuy = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"purchase1.png"] style: UIBarButtonItemStylePlain target:self action:@selector(buy:)];
    
    UIBarButtonItem *btnMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:(UIBarButtonItemStylePlain) target:(self.revealViewController) action:(@selector(revealToggle:))];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnBuy,self.garbage,nil]];
    [self.navigationItem setLeftBarButtonItem:btnMenu ];
     
    [self.tableView addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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
    [[GlobalElectrodom getInstance]addProduct:product];
    
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
    [[GlobalElectrodom getInstance]removeProduct:product];
    
    amount = amount - (product.quantity * product.price);
    NSString *tot = [[NSNumber numberWithLong:amount] stringValue];
    total_amount.text  = [NSString stringWithFormat: @"%@ %@", @"$", tot];

    [self loadObjects];
    [self.tableView reloadData];
    
    
}
- (IBAction)delete_Cart:(id)sender {
    
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Confirmación"
                                                      message:@"Confirma que desea borrar su orden actual?"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Si", @"No", nil];
    myAlert.tag=100;
    [myAlert show];
    
    
    /*[Product unpinAllObjects];
    amount = 0;
    NSString *tot = [[NSNumber numberWithLong:amount] stringValue];
    total_amount.text  = [NSString stringWithFormat: @"%@ %@", @"$", tot];
    [self loadObjects];
    */

}



-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    // Is this my Alert View?
    if (alertView.tag == 100) {
        //Yes
        
        
        // You need to compare 'buttonIndex' & 0 to other value(1,2,3) if u have more buttons.
        // Then u can check which button was pressed.
        if (buttonIndex == 0) {// 1st Other Button
            [[GlobalElectrodom getInstance]restoreOrder];
            GlobalElectrodom * instance = [GlobalElectrodom getInstance];
            instance.totalProducts=  0;
            amount = 0;
            NSString *tot = [[NSNumber numberWithLong:amount] stringValue];
            total_amount.text  = [NSString stringWithFormat: @"%@ %@", @"$", tot];
            [self loadObjects];
        }
        else if (buttonIndex == 1) {// 2nd Other Button
            
            
        }
        
    }
    else {
        //No
        // Other Alert View
        
    }
    
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