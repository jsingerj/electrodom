//
//  OrderViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 17/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "OrderViewController.h"

@implementation OrderViewController

@synthesize card_number;
@synthesize security_number;
@synthesize adress;
@synthesize card_picture;






- (void)viewDidLoad
{
    card_number.userInteractionEnabled = NO;
    adress.userInteractionEnabled = NO;
    
    NSMutableArray* paymentArray = [[NSMutableArray alloc] init];
    
    // add some sample data
    [paymentArray addObject:@"En caja"];
    [paymentArray addObject:@"Online"];
    
  //  self.downPicker = [[DownPicker alloc] initWithTextField:self.yourTextField withData:paymentArray];
}



- (IBAction)complete_order:(id)sender {
  //codigo seguridad igual codigo registrado de la base
 /*   if(security_number.text!=)
    {
        
        
    }
    else
    {
        
        
    }
   */
    
}


@end
