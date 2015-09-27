//
//  GlobalElectrodom.h
//  Electrodom
//
//  Created by Jacobo Singer on 26/9/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalElectrodom : NSObject


+(GlobalElectrodom *)getInstance;

-(int)signIn:(NSString *)email pass:(NSString *)pass;



@end
