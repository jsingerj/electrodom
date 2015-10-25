//
//  OrderViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 17/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "ViewController.h"
//#import "DownPicker.h"
#import "Card.h"
#import "Order.h"
#import "Address.h"
#import "ProductOrder.h"

@interface OrderViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>



/*GENERAL INFO*/
@property (strong, nonatomic) NSArray *countryNames;
@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) NSArray *cardsAvailable;
@property (strong, nonatomic)  Address *selected_address;
@property (strong, nonatomic)  Order *order;
@property (nonatomic)  int total_price;

/*RESUME*/
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switcher;


/*SUBVIEWS*/
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *cardView;


/*ADDRESS*/
@property (weak, nonatomic) IBOutlet UITextField *savedCard;
@property (weak, nonatomic) IBOutlet UITextField *savedAddress;
@property (weak, nonatomic) IBOutlet UIView *enterAddress;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *door;
@property (weak, nonatomic) IBOutlet UITextField *office;



/*CARD*/
@property (weak, nonatomic) IBOutlet UIView *enterCard;
@property (weak, nonatomic) IBOutlet UITextField *card_holder_name;
@property (weak, nonatomic) IBOutlet UITextField *card_number;
@property (weak, nonatomic) IBOutlet UITextField *card_cvv;
@property (weak, nonatomic) IBOutlet UITextField *card_expiry_month;
@property (weak, nonatomic) IBOutlet UITextField *card_expiry_year;


//PICKER VIEWS
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCard;



@property(nonatomic) int data_fetched;
@end
