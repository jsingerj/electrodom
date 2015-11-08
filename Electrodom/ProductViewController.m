//
//  ProductViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductDetailViewController.h"
#import "Product.h"
#import "SWRevealViewController.h"
#import "GlobalElectrodom.h"
@interface ProductViewController ()


@end

@implementation ProductViewController {
    
}



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
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    PFQuery *query=[PFQuery queryWithClassName:@"Product"];
    [query fromLocalDatastore];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error)
    {
        if (!error) {
            GlobalElectrodom * instance = [GlobalElectrodom getInstance];
            instance.totalProducts=count;
        }
    }];

    
    
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
    [query includeKey:@"CategoryId"];
    [query includeKey:@"promotionID"];
    
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
    
    
    
    UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:103];
    long  price = [[object objectForKey:@"price"] longValue];
    
    NSString *strFromInt = [[NSNumber numberWithLong:price] stringValue];
    NSString *varyingString1 = @"$";
    NSString *varyingString2 = strFromInt;
    NSString *str = [NSString stringWithFormat: @"%@ %@", varyingString1, varyingString2];
    prepTimeLabel.text = str ;

    Promotion * p = [object objectForKey:@"promotionID"];

    UILabel *offerLabel = (UILabel*) [cell viewWithTag:120];
    if(p!=nil)
    {
        offerLabel.text = @"Oferta";
        PFQuery *quer = [PFQuery queryWithClassName:@"Promotion"];
        Promotion *prom = (Promotion *)[[quer whereKey:@"objectId" equalTo:p.objectId] getFirstObject];
        long disc = [[prom objectForKey:@"Discount"]longValue];
        float x = 1 - ((float)disc/100);
        long finalPrice = price * x ;
        NSString *strFromInt = [[NSNumber numberWithLong:finalPrice] stringValue];
        NSString *str = [NSString stringWithFormat: @"%@ %@", varyingString1, strFromInt];
        prepTimeLabel.text = str ;
        [prepTimeLabel setFont:[UIFont boldSystemFontOfSize:17]];
        
     
    } else {
        offerLabel.text = @"";
        [prepTimeLabel setFont:[UIFont systemFontOfSize:17]];
        
    }

    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"picture"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //  thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"name"];
    
    UILabel *description = (UILabel*) [cell viewWithTag:102];
    NSString *desc =[object objectForKey:@"description"];
    description.text = desc;
    
    UILabel *brandLabel = (UILabel*) [cell viewWithTag:105];
    brandLabel.text = [object objectForKey:@"Marca"];
    
    
    
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
        
        Product  *product = (Product *)[self.objects objectAtIndex:indexPath.row];
     /*   Product *product = [[Product alloc] initWithClassName:@"Product"];
        product.name = [object objectForKey:@"name"];
        product.picture = [object objectForKey:@"picture"];
        product.price = [[object objectForKey:@"price"] longValue];
        NSString  * desc =[object objectForKey:@"description"];
        product.description =desc;
        product.brand = [object objectForKey:@"Marca"];
        product.promotion = [object objectForKey:@"promotionID"];
        
        

        product.CategoryId = [object objectForKey:@"CategoryId"];
      */
        destViewController.product = product;
        
    }
      
}





@end


