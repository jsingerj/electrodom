//
//  CashViewController.m
//  Electrodom
//
//  Created by Jacobo Singer on 31/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import "CashViewController.h"
#import "ConfirmationViewController.h"
#import "SWRevealViewController.h"
#import "GlobalElectrodom.h"
@interface CashViewController ()

@end

@implementation CashViewController
@synthesize cashOrder;
@synthesize orderId;
- (void)viewDidLoad {
    [super viewDidLoad];
    orderId.text = cashOrder.order.objectId;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)confirmCashPayment:(id)sender {
    cashOrder.order.status= [cashOrder.order getStatus:@"APPROVED"];
    [cashOrder saveInBackgroundWithBlock:^(BOOL saved, NSError *error) {
        UIAlertView* alertView ;
        if(saved){
            alertView = [[UIAlertView alloc] initWithTitle:@"Pago con éxito!" message:@"Gracias por confiar en Electrodom" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [[GlobalElectrodom getInstance]restoreOrder];
            ConfirmationViewController *controller = (ConfirmationViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmationViewController"];
            controller.order = cashOrder.order;
            SWRevealViewController *rvc = self.revealViewController;
            UINavigationController* navController = (UINavigationController*)rvc.frontViewController;
            [navController setViewControllers: @[controller] animated: NO ];
            [rvc setFrontViewPosition: FrontViewPositionLeft animated: YES];
            
            
        }else{
            alertView = [[UIAlertView alloc] initWithTitle:@"Ocurrió un error, intente nuevamente" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
        }
        [alertView show];

    }];
}

@end
