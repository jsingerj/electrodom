//
//  Address.m
//  Electrodom
//
//  Created by Jacobo Singer on 18/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import "Address.h"

@implementation Address


@dynamic user;
@dynamic  office;
@dynamic door;
@dynamic street;

+ (NSString *)parseClassName {
    return @"Address";
}

+ (void)load {
    [self registerSubclass];
}


@end
