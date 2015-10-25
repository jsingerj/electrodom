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

@implementation CardsViewController

@synthesize card_cvv;
@synthesize card_holder;
@synthesize card_number;
@synthesize bank_image;




- (void)viewDidLoad
{
    
    PFUser *user =    [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Card"];
    NSString *objId = user.objectId;
    Card *card = (Card *)[[query whereKey:@"userID" equalTo:objId] getFirstObject];
    card_holder.text =  card.card_holder;
    card_number.text = [[NSNumber numberWithLong:card_number] stringValue];
    card_cvv.text = [[NSNumber numberWithLong:card_cvv] stringValue];
    card.bank = [card objectForKey:@"last_name"];
    
    PFQuery *bankquery = [PFQuery queryWithClassName:@"Bank"];
    Bank *bank = (Bank *)[[bankquery whereKey:@"BankID" equalTo:card.bank] getFirstObject];
    PFFile *thumbnail = [bank objectForKey:@"picture"];
   /* PFImageView *thumbnailImageView = (PFImageView*);
    thumbnailImageView.file = thumbnail;
   [thumbnailImageView loadInBackground];*/

    
    
}





@end
