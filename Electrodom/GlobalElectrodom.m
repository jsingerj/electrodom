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
        
    }
    return instance;
}


@end
