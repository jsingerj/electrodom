//
//  MyOrdersViewController.m
//  Electrodom
//
//  Created by Juan Cambón on 27/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "MyOrdersViewController.h"

@interface MyOrdersViewController()

@property (nonatomic, strong) NSArray *resultados;

@end

@implementation MyOrdersViewController

- (IBAction)changedTab:(id)sender {
    NSString *message = [NSString stringWithFormat:@"%ld", self.segmentedControl.selectedSegmentIndex];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex == 0) { // pendientes
//        self.resultado = query de En curso
        
        PFQuery *query = [PFQuery queryWithClassName:@"Order"];
        [query whereKey:@"status" equalTo:@"0"];
        [query whereKey:@"user" equalTo:[PFUser currentUser] ];
        self.resultados = query;
        

         
    }
    else
        if (self.segmentedControl.selectedSegmentIndex == 1) { //
            //        self.resultado = query de Enviados
            PFQuery *query = [PFQuery queryWithClassName:@"Order"];
            [query whereKey:@"status" equalTo:@"1"];
            [query whereKey:@"user" equalTo:[PFUser currentUser] ];
        }
    else
    {
        PFQuery *query = [PFQuery queryWithClassName:@"Order"];
        [query whereKey:@"status" equalTo:@"2"];
        [query whereKey:@"user" equalTo:[PFUser currentUser] ];
    }
    
//     return self.resultado.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
//    Object = self.resultados[row]
//    llenar la celda
    return nil;
}

@end
