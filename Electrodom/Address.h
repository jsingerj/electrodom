//
//  Address.h
//  Electrodom
//
//  Created by Jacobo Singer on 18/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import <Parse/Parse.h>

@interface Address : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *door;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *office;
@property (nonatomic, strong) PFUser * user;
//@property (nonatomic, strong) NSString *objectId;



@end
