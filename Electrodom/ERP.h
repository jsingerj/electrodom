//
//  ERP.h
//  Electrodom
//
//  Created by Jacobo Singer on 27/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//
#import "ERP.h"
#import "Order.h"
#import <Parse/Parse.h>

@interface ERP : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) Order *order;

@property (nonatomic) long total_price;


@end
