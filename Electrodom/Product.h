//
//  Product.h
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Product : PFObject<PFSubclassing>

//agregar el id
//agregar el resto del os datos de la tabla
//si no hay orden, relacioanrlo a un usuario
+ (NSString *)parseClassName;
@property (nonatomic, strong) NSString *name; // name of product
@property (nonatomic, strong) NSString *description; //product description
@property (nonatomic, strong) PFFile *picture; // image of recipe
@property (nonatomic) long  price;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic) int  quantity;
@property (nonatomic, strong) NSString *categoryId;



@end
