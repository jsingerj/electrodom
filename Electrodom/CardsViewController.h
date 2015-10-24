//
//  CardsViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 22/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "ViewController.h"

@interface CardsViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *card_holder;
@property (weak, nonatomic) IBOutlet UILabel *card_number;

@property (weak, nonatomic) IBOutlet UILabel *card_cvv;

@property (weak, nonatomic) IBOutlet UIImageView *bank_image;

@end
