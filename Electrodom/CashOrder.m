//
//  CashOrder.m
//  Electrodom
//
//  Created by Jacobo Singer on 31/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import "CashOrder.h"

@implementation CashOrder


@dynamic  order;
+ (NSString *)parseClassName {
    return @"CashOrder";
}

+ (void)load {
    [self registerSubclass];
}


@end
