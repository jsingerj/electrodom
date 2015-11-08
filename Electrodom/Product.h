//
//  Product.h
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Categorie.h"

#import "Promotion.h"
@interface Product : PFObject<PFSubclassing>


+ (NSString *)parseClassName;
@property (nonatomic, strong) NSString *name; // name of product
@property (nonatomic, strong) NSString *description; //product description
@property (nonatomic, strong) PFFile *picture; // image of recipe
@property (nonatomic) long  price;
@property (nonatomic, strong) NSString *Marca;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic) int  quantity;
@property (nonatomic, strong) Promotion *promotion;
@property (nonatomic, strong) Categorie *CategoryId;



@end
