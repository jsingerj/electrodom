//
//  Order.m
//  Electrodom
//
//  Created by Juan Cambón on 13/10/15.
//  Copyright © 2015 Juan Cambón. All rights reserved.
//

#import "Order.h"
//#import "Product.h"
#import "ProductOrder.h"
@implementation Order

@dynamic address;
@dynamic price;
@dynamic stars;
@dynamic status;
@dynamic comment;
@dynamic  date;
@synthesize  productsOrders;

+ (NSString *)parseClassName {
    return @"Order";
}

+ (void)load {
    [self registerSubclass];
}

-(void) addProduct:(Product * )product withQuantity:(int)quantity{
    ProductOrder * productOrder =[[ProductOrder alloc]initWithClassName:@"ProductOrder"];
    productOrder.product= product;
    productOrder.quantity=quantity;
    productOrder.price = productOrder.quantity *  product.price;
    if(productsOrders==nil){
        productsOrders = [[NSMutableArray alloc] init];
    }
    [productsOrders addObject:productOrder] ;
    
}
-(bool)savee{
    [super save];
    for (int i=0; i<[productsOrders count]; i++) {
        PFRelation *relationProduct = [self relationForKey:@"products"];
        ProductOrder * productOrder = (ProductOrder* )[productsOrders objectAtIndex:i];
        productOrder.order = self;
        [productOrder save];
        [relationProduct addObject:productOrder];
    }
    [super save];
    return true;
}

-(long)getStatus:(NSString *)fromString {
    
    if ([fromString isEqualToString:@"APPROVED"]){
        return 1 ;
    }else if([fromString isEqualToString:@"REJECTED"]){
        return 2;
    }
    return 0 ;
}


@end
