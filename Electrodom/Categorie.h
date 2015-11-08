//
//  Category.h
//  Electrodom
//
//  Created by Juan Cambón on 24/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import <Parse/Parse.h>

@interface Categorie : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *name;

+ (NSString *)parseClassName;


@end
