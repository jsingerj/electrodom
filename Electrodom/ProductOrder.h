//
//  ProductOrder.h
//  Electrodom
//
//  Created by Jacobo Singer on 18/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import <Parse/Parse.h>
#import "Product.h"
#import "Order.h"

@interface ProductOrder : PFObject<PFSubclassing>


@property (nonatomic, strong) Product* product;
@property (nonatomic, strong) Order* order;

@property (nonatomic) long quantity;
@property (nonatomic) long price;



@end
