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


-(int)signIn:(NSString *)email pass:(NSString *)pass{
   // [NSThread sleepForTimeInterval:10.0f];
    
 //   PFUser *user = [PFUser  objectWithClassName:@"User"];
 //   user[@"username"] = email;
 //   user[@"password"] = pass;
 //   [user saveInBackground];
    
    
    PFUser *user = [PFUser user];
    user.username = email;
    user.password =pass;
    user.email = email;
    
    // other fields can be set just like with PFObject
  //  user[@"phone"] = @"415-392-0202";
    
   [PFUser logInWithUsernameInBackground:email password:pass
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                        } else {
                                            // The login failed. Check error to see why.
                                        }
                                    }];
    
    
    return 1;
}


@end
