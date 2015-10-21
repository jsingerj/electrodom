//
//  Order.h
//  Electrodom
//
//  Created by Juan Cambón on 13/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Address.h"
#import "Product.h"

@interface Order : PFObject<PFSubclassing>


@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic) long status;
@property (nonatomic) long stars;
@property (nonatomic) long price;

//@property (nonatomic, strong) PFUser* user;
@property (nonatomic, strong) Address* address;
@property (nonatomic, strong) NSMutableArray* productsOrders;
-(void) addProduct:(Product * )product withQuantity:(int)quantity;

@end
