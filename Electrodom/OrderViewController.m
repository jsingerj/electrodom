//
//  OrderViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 17/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "OrderViewController.h"

@implementation OrderViewController

@synthesize totalLabel;
@synthesize total_price;
@synthesize products;
@synthesize switcher;
@synthesize savedAddress;
@synthesize  enterAddress;
@synthesize  selected_address;
@synthesize enterCard;
@synthesize card_cvv;
@synthesize pickerView;
@synthesize pickerCard;

@synthesize card_expiry_month;
@synthesize card_expiry_year;
@synthesize card_holder_name;
@synthesize card_number;
@synthesize order;
@synthesize savedCard;
@synthesize infoView;




- (IBAction)setOn:(id)sender {
    if([sender isOn]){
        [self.infoView setHidden:NO];
        [self.cardView setHidden:NO];
        
    } else{
        [self.infoView setHidden:YES];
        [self.cardView setHidden:YES];
    }
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag==101){
        
        
        
        // Do whatever you want
        if (![self.pickerView isHidden]){//si esta visible el picker view
            [enterAddress setHidden:NO];
            [pickerView setHidden:YES];
            savedAddress.placeholder = @"Seleccionar dirección existente";
            
        }else{
            [pickerView setHidden:NO];
            [enterAddress setHidden:YES];
            savedAddress.placeholder = @"Ingresar dirección";
            
            
        }
    }else if(textField.tag==102){
        if (![pickerCard isHidden]){//si esta visible el picker view
            [enterCard setHidden:NO];
            [pickerCard setHidden:YES];
            savedCard.placeholder = @"Seleccionar tarjeta existente";
            
        }else{
            [pickerCard setHidden:NO];
            [enterCard setHidden:YES];
            savedCard.placeholder = @"Ingresar tarjeta";
        }
    }
    
    return NO;
}


- (void)viewDidLoad
{
    [self creatOrder];
    PFQuery * query = [PFQuery queryWithClassName:@"Address"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    PFQuery * cardQuery = [PFQuery queryWithClassName:@"Card"];
    [cardQuery whereKey:@"userID" equalTo:[PFUser currentUser]];
    
    _cardsAvailable = [cardQuery findObjects];
    
    if([_cardsAvailable count]==1){
        Card *card = [_cardsAvailable objectAtIndex:0];
        [self loadCardView:card];
        order.card = card;
        
    }
    if([_cardsAvailable count]<=1){
        [savedCard
         setHidden:YES];
    }
    _countryNames= [query findObjects ];
    savedAddress.delegate = self;
    savedCard.delegate=self;
    
    
    
    
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)myPickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(myPickerView.tag==110){
        return _countryNames.count;
        
    }else if(myPickerView.tag==120){
        return _cardsAvailable.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)myPickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if(myPickerView.tag==110){
        Address * address=  (Address*)_countryNames[row];
        return [[address.street stringByAppendingString:@" "]stringByAppendingString:address.door ];
        
    }
    else if(myPickerView.tag==120){
        Card * myCard=  (Card * )_cardsAvailable[row];
        NSString * card_string=    [[NSNumber numberWithLong:myCard.card_number] stringValue];
        return card_string;
        
    }
    return @"";
    
}

-(void)pickerView:(UIPickerView *)myPickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if(myPickerView.tag==110){
        Address * myAddress=  (Address*)_countryNames[row];
        [self loadAddressView:myAddress];
        [enterAddress setHidden:NO];
        [pickerView setHidden:YES];
        selected_address  = myAddress;
        savedAddress.placeholder = @"Seleccionar dirección existente";
        order.address = myAddress;
    }else if(myPickerView.tag==120){
        Card * myCard=  (Card*)_cardsAvailable[row];
        [self loadCardView:myCard];
        order.card=myCard;
        savedCard.text=@"Seleccionar tarjeta existente";
        [enterCard setHidden:NO];
        [pickerCard setHidden:YES];
    }
    
}
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(void)loadAddressView:(Address *)myAddress{
    self.address.text = myAddress.street;
    self.door.text = myAddress.door;
    self.office.text = myAddress.office;
    
}
-(void)loadCardView:(Card *)myCard{
    //    card_cvv.text =   [[NSNumber numberWithLong:myCard.cvv] stringValue];
    card_holder_name.text= [myCard objectForKey:@"Card_holder"];
    card_number.text=  [[NSNumber numberWithLong:myCard.card_number] stringValue];
    card_expiry_month.text= [[NSNumber numberWithLong:[self getExpirationMonth:myCard ]] stringValue];
    card_expiry_year.text = [[NSNumber numberWithLong:[self getExpirationYear:myCard ]] stringValue];
    
}

-(NSInteger)getExpirationMonth:(Card * )forCard {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* componentObj = [calendar components:unitFlags fromDate:[forCard objectForKey:@"Expiry_date" ]];
    return  componentObj.month;
}

-(NSInteger)getExpirationYear:(Card * )forCard {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* componentObj = [calendar components:unitFlags fromDate:[forCard objectForKey:@"Expiry_date" ]];
    return  componentObj.year;
}
-(void)creatOrder{
    
    order = [[Order alloc]initWithClassName:@"Order"];
    //   order.comment=@"Testing";
    order.status  =0 ;
    //   order.stars = 1;
    //   order.address = address;
    
    PFQuery *produtQuery = [PFQuery queryWithClassName:@"Product"];
    
    [produtQuery fromLocalDatastore];
    products   = [produtQuery findObjects];
    
    for (int i = 0 ; i<[products count]; i++) {
        Product * p = (Product *)[products objectAtIndex:i];
        [order addProduct:p withQuantity:p.quantity];
        total_price+= p.price * p.quantity;
    }
    NSString *strFromInt = [NSString stringWithFormat:@"%d",total_price];
    
    totalLabel.text = strFromInt ;
    order.price=total_price;
    
    /*CREAR ORDEN CON PRODUCTS ASOCIADOS, ESTA HARDOCDEADO, SACAR HARCODEO Y TOMAR DLE AS VISTAS CORRESPONDIENTES-TANTO PRODUCTOS OCMO INFO PERSONAL-
     Address * address = [[Address alloc]initWithClassName:@"Address"];
     address.street = @"9 de junio";
     address.office = @"ap1";
     address.door = @"447022";
     PFUser * user = [PFUser currentUser];
     address.user = user;
     
     Order * order = [[Order alloc]initWithClassName:@"Order"];
     order.price=1000;
     order.comment=@"Testing";
     order.status  =0 ;
     order.stars = 1;
     order.address = address;
     
     PFQuery *query = [PFQuery queryWithClassName:@"Product"];
     Product *product = (Product *)[[query whereKey:@"objectId" equalTo:@"U271hoqquY"] getFirstObject];
     [order addProduct:product withQuantity:2];
     product = (Product *)[[query whereKey:@"objectId" equalTo:@"zJA2giXzFS"] getFirstObject];
     [order addProduct:product withQuantity:4];
     
     
     [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
     NSLog(succeeded ? @"Yes" : @"No");
     if(succeeded){
     for (int i=0; i<[order.productsOrders count]; i++) {
     PFRelation *relationProduct = [order relationForKey:@"products"];
     ProductOrder * productOrder = (ProductOrder* )[order.productsOrders objectAtIndex:i];
     productOrder.order = order;
     [productOrder save];
     [relationProduct addObject:productOrder];
     }
     [order save];
     PFRelation *relation = [user relationForKey:@"Orders"];
     [relation addObject:order];
     [user save];
     }
     }
     ];
     /*FORMA DE TRAER TODAS LAS ORDENES DE UN USUARIO, Y LUEGO EL PRODUCTO DE CADA ORDEN
     //Traer todas las ordenes de un usuario:
     PFUser * user = [PFUser currentUser];
     PFRelation *relation = [user relationForKey:@"Orders"];
     PFQuery * query = [relation query];
     NSArray * orders = [query findObjects];
     for(int i=0;i<[orders count];i++){
     //Obtengo la orden y pregunto por cada producto.
     Order * currentOrder=  (Order *)[orders objectAtIndex:i];
     PFRelation *productRelations = [currentOrder relationForKey:@"products"];
     PFQuery * queryProducts = [productRelations query];
     NSArray * products = [queryProducts findObjects];
     NSLog(@"%@", currentOrder);
     NSLog(@"%@", products);
     
     
     
     }
     */
}
- (IBAction)confirmOrder:(id)sender {
    
    /*CREAR ORDEN CON PRODUCTS ASOCIADOS, ESTA HARDOCDEADO, SACAR HARCODEO Y TOMAR DLE AS VISTAS CORRESPONDIENTES-TANTO PRODUCTOS OCMO INFO PERSONAL-*/
    
    PFUser * user = [PFUser currentUser];
    Address * address = [self getAddressForOrder];
    order.address = address;
    [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(succeeded ? @"Yes" : @"No");
        if(succeeded){
            for (int i=0; i<[order.productsOrders count]; i++) {
                PFRelation *relationProduct = [order relationForKey:@"products"];
                ProductOrder * productOrder = (ProductOrder* )[order.productsOrders objectAtIndex:i];
                productOrder.order = order;
                [productOrder save];
                [relationProduct addObject:productOrder];
            }
            [order save];
            PFRelation *relation = [user relationForKey:@"Orders"];
            [relation addObject:order];
            [user save];
        }
    }
     ];
    
    
    
}

-(Address *)getAddressForOrder{
    NSString * viewStreet = self.address.text;
    NSString * viewOffice = self.office.text;
    NSString * viewDoor = self.door.text;
    
    Address * address = [[Address alloc]initWithClassName:@"Address"];
    address.street = viewStreet;
    address.office = viewOffice;
    address.door = viewDoor;
    address.user = [PFUser currentUser];
    
    if(order.address !=nil){
        bool isEqual =  [viewOffice isEqualToString:order.address.office] &&
        [viewStreet isEqualToString:order.address.street] && [viewDoor isEqualToString:order.address.door];
        if(isEqual){
            return order.address;
        }
    }
    return address;
}

-(Card * )getCardForOrder {
    
    Card * card = [[Card alloc]initWithClassName:@"Card"];
    card.Card_holder =self.card_holder_name.text;
    card.cvv=[self.card_number.text longLongValue];
    
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:self.card_number.text];
    card.card_number= [myNumber longLongValue];
    
    NSInteger  viewExpiryYear = [card_expiry_year.text integerValue];
    NSInteger  viewExpiryMonth = [card_expiry_month.text integerValue];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:viewExpiryMonth];
    [comps setYear:viewExpiryYear];
    NSDate * expiration = [[NSCalendar currentCalendar] dateFromComponents:comps];
    card.Expiry_date = expiration;
    
    if(order.card !=nil){
        //check cvv
        if(order.card.cvv !=card.cvv){
            return nil;
        }
        bool isEqual =isEqual && [card.Card_holder isEqualToString:order.card.Card_holder] &&
        card.card_number==order.card.card_number && viewExpiryMonth ==[self getExpirationMonth:order.card] &&
        viewExpiryYear== [self getExpirationYear:order.card];
        if(isEqual){
            return order.card;
        }
    }
    /*
     card.user =[PFUser currentUser];
     
     
     //card_expiry_month.text= [[NSNumber numberWithLong:[self getExpirationMonth:myCard ]] stringValue];
     // card_expiry_year.text = [[NSNumber numberWithLong:[self getExpirationYear:myCard ]] stringValue];
     
     
     
     
     
     Address * address = [[Address alloc]initWithClassName:@"Address"];
     address.street = viewStreet;
     address.office = viewOffice;
     address.door = viewDoor;
     address.user = [PFUser currentUser];
     
     if(order.address !=nil){
     bool isEqual =  [viewOffice isEqualToString:order.address.office] &&
     [viewStreet isEqualToString:order.address.street] && [viewDoor isEqualToString:order.address.door];
     if(isEqual){
     return order.address;
     }
     }
     return address;
     */
    
    return nil;
}


@end
