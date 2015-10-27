//
//  ERP.m
//  Electrodom
//
//  Created by Jacobo Singer on 27/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import "ERP.h"
#import "Order.h"

@implementation ERP

@dynamic total_price;
@dynamic  order;
+ (NSString *)parseClassName {
    return @"ERP";
}

+ (void)load {
    [self registerSubclass];
}


@end
