//
//  CardsViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 22/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "CardsViewController.h"
#import "Card.h"
#import "User.h"
#import "Bank.h"
#import "MessageDictionary.h"

@implementation CardsViewController


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //  _barButton.target = self.revealViewController;
    //  _barButton.action = @selector(revealToggle:);
    UITableView * table = self.tableView;
    //   [self.tableView addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Do any additional setup after loading the view, typically from a nib.
    // _barButton.target = self.revealViewController;
    // _barButton.action = @selector(revealToggle:);
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (PFQuery *)queryForTable
{
   
   
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"active" equalTo:[NSNumber numberWithBool:YES]];
    [query whereKey:@"userID" equalTo:[PFUser currentUser]];
  
     return query;
    
   
}



- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Card";
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"CardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:100];
    nameLabel.text = [object objectForKey:@"Card_holder"];
    
    
    Bank *b = [object objectForKey:@"BankId"];
    NSString *idB = b.objectId;
    
    
    PFQuery *quer = [PFQuery queryWithClassName:@"Bank"];
    Bank *ba = (Bank *)[[quer whereKey:@"objectId" equalTo:idB] getFirstObject];
    
    
   
    PFFile *thumbnail = [ba objectForKey:@"picture"];
     UIImageView* cardImage = (UIImageView*)[cell viewWithTag:200];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        UIImage* myImage =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnail.url]]];
        
        
        dispatch_sync(  dispatch_get_main_queue(), ^(void) {
            [cardImage setImage:myImage];        });
    });
    
   
    UIButton *delete_button = (UIButton *)[cell viewWithTag:107];
    
    
    UILabel *dateLabel = (UILabel*) [cell viewWithTag:102];
    NSDate *date = [object objectForKey:@"Expiry_date"];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* componentObj = [calendar components:unitFlags fromDate:date];
    NSInteger month = componentObj.month;
    NSInteger year = componentObj.year;
    
    NSString *auxM = [[NSNumber numberWithLong:month] stringValue];
    NSString *auxY = [[NSNumber numberWithLong:year] stringValue];
    auxY = [NSString stringWithFormat: @"%@%@", @"/", auxY];
    NSString *expDate = [NSString stringWithFormat: @"%@%@",auxM, auxY];
    dateLabel.text = expDate;
    
    
    
    
    
    
    UILabel *card_number = (UILabel*) [cell viewWithTag:101];
    long  number = [[object objectForKey:@"card_number"] longValue];
    card_number.text = [[NSNumber numberWithLong:number] stringValue];
 
    
    return cell;
    
     
    
}

-(IBAction)delete_buttonClicked:(id)sender

{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
   // NSString *test =  object.objectId;
    
    
    PFQuery *quer = [PFQuery queryWithClassName:@"Card"];
    Card *card = (Card *)[[quer whereKey:@"objectId" equalTo:object.objectId] getFirstObject];
    
    
    
    card[@"active"] = [NSNumber numberWithBool:NO];
 //   [object setObject:[NSNumber numberWithBool:NO] forKey:@"active"];
    [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Se elimino la tarjeta correctamente" message:@"OK" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
          [self loadObjects];
            [alertView show];
            
            
            
            // Hooray! Let them use the app now.
        } else {
            
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            
            MessageDictionary * dictionary =[[MessageDictionary alloc]init];
            NSString * customMessage = [dictionary getMessage:errorString];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error, no es posible eliminar la tarjeta." message:customMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         
            [alertView show];
            [super viewDidLoad];
            
        }
    }];
    
}






@end
