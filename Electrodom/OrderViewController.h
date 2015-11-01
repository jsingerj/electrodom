//
//  OrderViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 17/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"
#import "Order.h"
#import "Address.h"
#import "ProductOrder.h"
#import "CashOrder.h"
@interface OrderViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>



/*GENERAL INFO*/
@property (strong, nonatomic) NSArray *countryNames;
@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) NSArray *cardsAvailable;
@property (strong, nonatomic) NSArray *banksAvailable;



@property (strong, nonatomic)  Address *selected_address;
@property (strong, nonatomic)  Order *order;
@property (strong, nonatomic)  CashOrder *cashOrder;

@property (nonatomic)  int total_price;
@property (weak, nonatomic) IBOutlet UITextView *comments;

@property (weak, nonatomic) IBOutlet UILabel *textViewTittle;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/*RESUME*/
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switcher;


/*SUBVIEWS*/
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIView *offlinePayment;


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



/*NFC PAYMENT*/
@property (weak, nonatomic) IBOutlet UILabel *nfcLabel;
@property (weak, nonatomic) IBOutlet UISwitch *nfcSwitcher;

@property (weak, nonatomic) IBOutlet UILabel *nfcDisclaimer;

@property(nonatomic) int data_fetched;
@end
