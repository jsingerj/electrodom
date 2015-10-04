//
//  MessageDictionary.m
//  Electrodom
//
//  Created by Juan Cambón on 4/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "MessageDictionary.h"

@implementation MessageDictionary

- (id) init {
    self = [super init];
    if (self != nil) {
        // initializations go here.
    }
    return self;
}

- (NSString * )getMessage:(NSString *)fromString  {
    NSDictionary* messages = @{
                                   @"Este error": @"Hola",
                                   @"invalid email address": @"Email inválido",
                                   @"C": @4,
                                   
                                   @"X": @8,
                                   @"Y": @3,
                                   @"Z": @10,
                                   };
    
    if ([messages objectForKey:fromString]) {
        return [messages objectForKey:fromString];
        
    }
    return fromString;
}

@end
