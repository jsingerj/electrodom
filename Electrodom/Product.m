//
//  Product.m
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import "Product.h"
//#import "Category.h"

@implementation Product

 /*   @synthesize name; // name of product
    @synthesize description; //product description
    @synthesize picture; // image of recipe
    @synthesize  price;
*/

@dynamic name;
@dynamic description ;
@dynamic picture;
@dynamic brand;
@dynamic price;
@dynamic objectId;
@dynamic userId;
@dynamic quantity;
@dynamic promotion;
@dynamic categorie;

+ (NSString *)parseClassName {
    return @"Product";
}

+ (void)load {
    [self registerSubclass];
}
@end
