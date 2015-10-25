//
//  OrderViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 17/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "ViewController.h"
//#import "DownPicker.h"

@interface OrderViewController : ViewController



@property (weak, nonatomic) IBOutlet UITextField *card_number;
@property (weak, nonatomic) IBOutlet UITextField *security_number;
@property (weak, nonatomic) IBOutlet UIImageView *card_picture;
@property (weak, nonatomic) IBOutlet UITextField *adress;

@property (weak, nonatomic) IBOutlet UILabel *total_price;
//@property (weak, nonatomic) IBOutlet DownPicker *downPicker;

@end
