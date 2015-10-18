//
//  Product.m
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "Product.h"

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
@dynamic categoryId;

+ (NSString *)parseClassName {
    return @"Product";
}

@end
