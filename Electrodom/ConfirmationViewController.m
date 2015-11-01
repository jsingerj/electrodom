//
//  ConfirmationViewController.m
//  Electrodom
//
//  Created by Jacobo Singer on 27/10/15.
//  Copyright (c) 2015 Jacobo Singer. All rights reserved.
//

#import "ConfirmationViewController.h"
@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController

@synthesize order;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    UIView * view = self.view;
    UILabel * transactionId = (UILabel * )[view viewWithTag:102];
    transactionId.text=order.objectId;
    
    
    
 //  [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
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

@end
