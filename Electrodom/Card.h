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
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *card_holder;
@property (nonatomic, strong) Bank *bank;
@property (nonatomic, strong) NSDate *expiryDate;
@property (nonatomic) long card_number;
@property (nonatomic) long cvv;
@property (nonatomic, strong) User *user;

@end
