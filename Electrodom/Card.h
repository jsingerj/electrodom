//
//  Card.h
//  Electrodom
//
//  Created by Juan Cambón on 22/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"
#import "Bank.h"

@interface Card : PFObject <PFSubclassing>

+ (NSString *)parseClassName;
@property (nonatomic) long discount;
@property (nonatomic, strong) NSString *Card_holder;
@property (nonatomic, strong) Bank *BankId;
@property (nonatomic, strong) NSDate *Expiry_date;
@property (nonatomic) long card_number;
@property (nonatomic) long cvv;
@property (nonatomic, strong) PFUser *userID;

@end
