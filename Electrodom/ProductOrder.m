//
//  ProductOrder.m
//  Electrodom
//
//  Created by Juan Cambón on 18/10/15.
//  Copyright (c) 2015 Juan Cambón. All rights reserved.
//

#import "ProductOrder.h"

@implementation ProductOrder


@dynamic product;
@dynamic order;

@dynamic price;
@dynamic quantity;

+ (NSString *)parseClassName {
    return @"ProductOrder";
}

+ (void)load {
    [self registerSubclass];
}
@end
