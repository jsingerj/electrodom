//
//  GlobalElectrodom.h
//  Electrodom
//
//  Created by Juan Cambon on 26/9/15.
//  Copyright (c) 2015 Juan Cambon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
@interface GlobalElectrodom : NSObject


+(GlobalElectrodom *)getInstance;
@property (weak, nonatomic) Order *order;



@end
    