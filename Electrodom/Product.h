//
//  Product.h
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Product : NSObject

/*
@property NSString *name;
@property NSString *picture;
@property NSString *product_description;
@property int price;
*/

@property (nonatomic, strong) NSString *name; // name of product
@property (nonatomic, strong) NSString *description; //product description
@property (nonatomic, strong) PFFile *picture; // image of recipe
@property (nonatomic) int  price;


@end
