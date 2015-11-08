//
//  Promotion.m
//  Electrodom
//
//  Created by Juan Cambón on 20/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "Promotion.h"

@implementation Promotion

+ (NSString *)parseClassName {
    return @"Promotion";
}

+ (void)load {
    [self registerSubclass];
}
@dynamic Discount;
@dynamic objectId;
@dynamic date;

@end
