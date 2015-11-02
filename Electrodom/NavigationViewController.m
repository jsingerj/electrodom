//
//  NavigationViewController.m
//  SlideOutMenu
//
//  Created by Jared Davidson on 7/14/14.
//  Copyright (c) 2014 Archetapp. All rights reserved.
//

#import "NavigationViewController.h"
#import "ViewController.h"
#import "SWRevealViewController.h"
@interface NavigationViewController ()

@end

@implementation NavigationViewController{
    NSArray *menu;
    BOOL logout ;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    logout= false;
    menu = @[@"first", @"second", @"third", @"fourth",@"five",@"six",@"seven"];
    
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
   
  
    
   /*
    if ( [segue isKindOfClass: [SWRevealViewControllerSeguePushController class]] ) {
        SWRevealViewControllerSegueSetController *swSegue = (SWRevealViewControllerSegueSetController*) segue;
        swSegue.perform = ^(SWRevealViewControllerSegueSetController* rvc_segue, UIViewController* svc, UIViewController* dvc) {
       
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }*/
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"logOut"] ){
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Confirmación"
                                                          message:@"Desea cerrar sesión?"
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"Si", @"No", nil];
        myAlert.tag=100;
        [myAlert show];
        
        return logout;
    }
    return YES;
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    // Is this my Alert View?
    if (alertView.tag == 100) {
        //Yes
        
        
        // You need to compare 'buttonIndex' & 0 to other value(1,2,3) if u have more buttons.
        // Then u can check which button was pressed.
        if (buttonIndex == 0) {// 1st Other Button
            [[GlobalElectrodom getInstance]logOut];
            logout =true;
            [self performSegueWithIdentifier:@"logOut" sender:self];
        }
        else if (buttonIndex == 1) {// 2nd Other Button
            logout=false;
            
        }
        
    }
    else {
        //No
        // Other Alert View
        
    }
    
}









@end
