//
//  HomeViewController.m
//  Electrodom
//
//  Created by Juan Cambon on 26/9/15.
//  Copyright (c) 2015 Juan Cambon. All rights reserved.
//

#import "HomeViewController.h"

#import "SWRevealViewController.h"

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    __barButton.target = self.revealViewController;
    __barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}


@end


