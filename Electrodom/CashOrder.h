//
//  CashOrder.h
//  Electrodom
//
//  Created by Jacobo Singer on 31/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import <Parse/Parse.h>
#import "Order.h"
@interface CashOrder : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) Order *order;



@end
