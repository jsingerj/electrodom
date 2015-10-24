//
//  Bank.h
//  Electrodom
//
//  Created by Juan Cambón on 22/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <Parse/Parse.h>

@interface Bank :PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSString *name; // name of product
@property (nonatomic, strong) PFFile *picture; // image of recipe
@property (nonatomic, strong) NSString *objectId;

@end
