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
- (ProductViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"ProductCell";
    
    ProductViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[ProductViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Product *product = [[Product alloc] initWithClassName:@"Product"];
    product.name = [object objectForKey:@"name"];
    product.picture = [object objectForKey:@"picture"];
    product.price = [object objectForKey:@"price"];
    product.description = [object objectForKey:@"description"];
    product.brand = [object objectForKey:@"Marca"];
    
    
 
    
    
    cell.product = product;
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"picture"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //  thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    cell.product_name.text = product.name;
    cell.product_brand.text = product.brand;
    cell.quantity.text = [NSString stringWithFormat:@"%d",product.quantity];
    
    
    UILabel *prepTimeLabel = cell.total_price;
    int price = [object objectForKey:@"price"];
    NSString *strFromInt = [NSString stringWithFormat:@"%d",price];
    
    
    prepTimeLabel.text = strFromInt ;
    
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
    int price = product.price;
    cell.total_price.text = [[NSNumber numberWithDouble:price* value] stringValue];
  }

- (IBAction)deleteItem:(id)sender {
    [self.product unpin];
    
}
- (IBAction)delete_Cart:(id)sender {
    [Product unpinAllObjects];
    

}


@end