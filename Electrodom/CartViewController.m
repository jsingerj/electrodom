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
@interface CartViewController ()


@end


@implementation CartViewController





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
    NSString *varyingString1 = @"$";
    NSString *varyingString2 =[[NSNumber numberWithLong:(product.price * quantiy)] stringValue];
     NSString *str = [NSString stringWithFormat: @"%@ %@", varyingString1, varyingString2];
    prepTimeLabel.text=str;
    [cell.stepper setValue:quantiy];
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
    product.quantity+=1;
    [product pin];
    long price = product.price;
    
    NSString *varyingString1 = @"$";
    NSString *varyingString2 = [[NSNumber numberWithDouble:price* value] stringValue];;
    NSString *str = [NSString stringWithFormat: @"%@ %@", varyingString1, varyingString2];
    cell.total_price.text = str;
  }


-(void)calculateAmounts
{
    
    
}

- (IBAction)deleteItem:(id)sender {
    [self loadObjects];
    
}
- (IBAction)delete_Cart:(id)sender {
    [Product unpinAllObjects];
    [self loadObjects];
    

}




@end