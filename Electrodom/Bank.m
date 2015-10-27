//
//  Bank.m
//  Electrodom
//
//  Created by Juan Cambón on 22/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "Bank.h"

@implementation Bank

+ (NSString *)parseClassName {
    return @"Bank";
}
+ (void)load {
    [self registerSubclass];
}


@dynamic picture;
@dynamic name;
@dynamic objectId;

@end
