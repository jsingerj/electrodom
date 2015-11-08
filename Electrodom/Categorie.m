//
//  Category.m
//  Electrodom
//
//  Created by Juan Cambón on 24/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "Categorie.h"

@implementation Categorie

+ (NSString *)parseClassName {
    return @"Category";
}

+ (void)load {
    [self registerSubclass];
}
@end
