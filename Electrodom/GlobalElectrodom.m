//
//  GlobalElectrodom.m
//  Electrodom
//
//  Created by Juan Cambon on 26/9/15.
//  Copyright (c) 2015 Juan Cambon. All rights reserved.
//

#import "GlobalElectrodom.h"
#import <Parse/Parse.h>
@implementation GlobalElectrodom


static GlobalElectrodom *instance;
+(GlobalElectrodom *)getInstance{
    if (instance ==nil ) {
        instance = [[GlobalElectrodom alloc] init];
        instance.totalProducts=0;
        
    }
    return instance;
}
-(int)getTotalProducts{
    return self.totalProducts;
}
-(void)restoreOrder{
    [Product unpinAllObjects];
    self.totalProducts = 0;
}

-(BOOL)addProduct:(Product *)product{
    self.totalProducts +=1;
    [product pin];
    return YES;
}

-(BOOL)removeProduct:(Product *)product {
    self.totalProducts-=1;
    [product unpin];
    return YES;

}
-(void)logOut{
    [PFUser logOut];
}



@end
