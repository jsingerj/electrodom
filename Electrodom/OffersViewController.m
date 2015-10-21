//
//  OffersViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 20/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "OffersViewController.h"
#import "Product.h"
#import "Promotion.h"
#import "SWRevealViewController.h"
#import "ProductDetailViewController.h"

@implementation OffersViewController{}

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
    // Do any additional setup after loading the view, typically from a nib.
    // _barButton.target = self.revealViewController;
    // _barButton.action = @selector(revealToggle:);
    
   // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"ProductCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Promotion * p = [object objectForKey:@"promotionID"];
    
    if(p!=nil)
    {
        // Configure the cell
        PFFile *thumbnail = [object objectForKey:@"picture"];
        PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
        thumbnailImageView.file = thumbnail;
        [thumbnailImageView loadInBackground];
        
        UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
        nameLabel.text = [object objectForKey:@"name"];
        
        
        // UILabel *description = (UILabel*) [cell viewWithTag:102];
        //NSString *desc =[object objectForKey:@"description"];
        //description.text = desc;
        NSString *idProm = p.objectId;
        PFQuery *quer = [PFQuery queryWithClassName:@"Promotion"];
        Promotion *prom = (Promotion *)[[quer whereKey:@"objectId" equalTo:idProm] getFirstObject];
        long discount = [[prom objectForKey:@"Discount"]longValue];

        
        
        
        UILabel *discountLabel = (UILabel*) [cell viewWithTag:104];
        NSString *dis = [[NSNumber numberWithLong:discount] stringValue];
        NSString *vary = @"%";
        discountLabel.text = [NSString stringWithFormat: @"%@ %@", vary, dis];
        
        
        UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:103];
        long  price = [[object objectForKey:@"price"] longValue];
        NSString *strFromInt = [[NSNumber numberWithLong:price] stringValue];
        NSString *coin = @"$";
        NSString *str = [NSString stringWithFormat: @"%@ %@", coin, strFromInt];
        prepTimeLabel.text = str ;
        
        
        UILabel *fPrice = (UILabel*) [cell viewWithTag:106];
        long finalPrice = price * (1 - (discount/100));
        NSString *realP = [[NSNumber numberWithLong:finalPrice] stringValue];
        NSString *total = [NSString stringWithFormat: @"%@ %@", coin, realP];
        fPrice.text = total ;
        
        
        
        UILabel *brandLabel = (UILabel*) [cell viewWithTag:105];
        brandLabel.text = [object objectForKey:@"Marca"];
        return cell;
        
    }
    return cell;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showProductDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ProductDetailViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        Product *product = [[Product alloc] initWithClassName:@"Product"];
        product.name = [object objectForKey:@"name"];
        product.picture = [object objectForKey:@"picture"];
        product.price = [[object objectForKey:@"price"] longValue];
        NSString  * desc =[object objectForKey:@"description"];
        product.description =desc;
        product.brand = [object objectForKey:@"Marca"];
        product.promotion = [object objectForKey:@"promotion"];
        // product.categoryId = [object objectForKey:@"categoryId"];
        destViewController.product = product;
        
    }
}


@end
