//
//  ViewController.m
//  Electrodom
//
//  Created by Juan Cambon on 26/9/15.
//  Copyright (c) 2015 Juan Cambon. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"

#import "Product.h"
#import "ProductOrder.h"
#import "Order.h"
#import "Address.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize user_name;
@synthesize password;
@synthesize activityIndicator;
- (void)viewDidLoad {
    self.user_name.delegate= self;
    self.password.delegate=self;

    //SACAR EL DIA DE LA DEFENSA
    self.user_name.text = @"jjcambon88@gmail.com";
    self.password.text = @"111111";
    
    [super viewDidLoad];
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator stopAnimating];

    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logIn:(id)sender{
    if(! [self.activityIndicator isAnimating])
    {
        
        
        NSString * emailText= [self.user_name text];
        NSString * passwordText = [self.password text];
        
        if ([emailText length]==0 || [passwordText length]==0){
            UIAlertView *messageView = [[UIAlertView alloc] initWithTitle:@"Inicio sesión " message:@"Por favor complete la contraseña y el mail para ingresar " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [messageView show];
            return ;
            
        }
        
        //agregar chequeo si es valido el mail.
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidden:NO];
        
        [PFUser logInWithUsernameInBackground:emailText password:passwordText
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self showHome];
                                            } else {
                                                NSString *message = [error localizedDescription];
                                                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Nombre de usuario y su Contraseña son incorrectos" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                    password.text=@"";
                                                [alertView show];
                                                
                                            }
                                            [self.activityIndicator stopAnimating];
                                            [self.activityIndicator setHidden:YES];
                                            
                                        }];
        
    }
    
}


-(void)showHome{
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
    
     */
/*FORMA DE TRAER TODAS LAS ORDENES DE UN USUARIO, Y LUEGO EL PRODUCTO DE CADA ORDEN */
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


    
    
    SWRevealViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}



@end
