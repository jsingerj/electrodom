//
//  Promotion.h
//  Electrodom
//
//  Created by Juan Cambón on 20/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <Parse/Parse.h>

@interface Promotion : PFObject<PFSubclassing>

+ (NSString *)parseClassName;
@property (nonatomic) long discount;
@property (nonatomic, strong) NSString *objectId;



@end
