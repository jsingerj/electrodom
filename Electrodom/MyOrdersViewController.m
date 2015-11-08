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
@property (nonatomic) Boolean enviado;
@property (nonatomic) Boolean entregado;
@property (nonatomic) Boolean encurso;
@end

@implementation MyOrdersViewController

- (IBAction)changedTab:(id)sender {
  /*  NSString *message = [NSString stringWithFormat:@"%ld", self.segmentedControl.selectedSegmentIndex];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];*/
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        PFUser * user = [PFUser currentUser];
        PFRelation *relation = [user relationForKey:@"Orders"];
        PFQuery * query = [relation query];
        [query includeKey:@"address"];
        [query whereKey:@"status" equalTo:@0];
        [query orderByDescending:@"date"];
        self.encurso = true;
        self.enviado = false;
        self.entregado= false;
        self.resultados = [query findObjects];
         
    }
    else
        if (self.segmentedControl.selectedSegmentIndex == 1) { //
            // Enviados
            PFUser * user = [PFUser currentUser];
            PFRelation *relation = [user relationForKey:@"Orders"];
            PFQuery * query = [relation query];
            [query includeKey:@"address"];
            [query whereKey:@"status" equalTo:@1];
            [query orderByDescending:@"date"];
            self.resultados = [query findObjects];
            self.encurso = false;
            self.enviado = true;
            self.entregado = false;
            
        }
    else
    {//ENTREGADOS
        PFUser * user = [PFUser currentUser];
        PFRelation *relation = [user relationForKey:@"Orders"];
        PFQuery * query = [relation query];
        [query includeKey:@"address"];
        [query whereKey:@"status" equalTo:@2];
        [query orderByDescending:@"date"];
        self.resultados = [query findObjects];
        self.encurso = false;
        self.entregado = true;
        self.enviado = false;
        
    }
    
    NSInteger x =  self.resultados.count;
    return x;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Order *o = self.resultados[indexPath.row];
   
    static NSString *simpleTableIdentifier = @"OrderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
  
    
    
    UILabel *codeOrderLabel = (UILabel*) [cell viewWithTag:100];
    codeOrderLabel.text = o.objectId;
   
    
   UILabel *dateLabel = (UILabel*) [cell viewWithTag:101];
    NSDate *date = o.date;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* componentObj = [calendar components:unitFlags fromDate:date];
    NSInteger day = componentObj.day;
    NSInteger month = componentObj.month;
    NSInteger year = componentObj.year;
    NSString *auxD = [[NSNumber numberWithLong:day] stringValue];
    NSString *auxM = [[NSNumber numberWithLong:month] stringValue];
    NSString *auxY = [[NSNumber numberWithLong:year] stringValue];
    auxY = [NSString stringWithFormat: @"%@%@", @"/", auxY];
    NSString *expDate = [NSString stringWithFormat: @"%@%@%@%@",auxD,@"/",auxM, auxY];
    dateLabel.text = expDate;

    
    
    UILabel *addressLabel = (UILabel*) [cell viewWithTag:102];
    addressLabel.text = [NSString stringWithFormat: @"%@%@%@%@%@",o.address.street,@" ",o.address.door,@", Apto. ",o.address.office];
    
    UILabel *priceLable = (UILabel*) [cell viewWithTag:103];
    NSString *strFromInt = [[NSNumber numberWithLong:o.price] stringValue];
    priceLable.text = [NSString stringWithFormat: @"%@%@",@"$",strFromInt];
   
    if(self.encurso)
    {
        UIButton *changeAddress = (UIButton*) [cell viewWithTag:104];
        [changeAddress setTitle:@"Cambiar dirección" forState:UIControlStateNormal];
    }
    else
    {
        UIButton *changeAddress = (UIButton*) [cell viewWithTag:104];
           [changeAddress setTitle:@"" forState:UIControlStateNormal];    }
    if(self.entregado)
    {
        UIButton *qualifyOrder = (UIButton*) [cell viewWithTag:105];
        [qualifyOrder setTitle:@"Calificar" forState:UIControlStateNormal];
        
    }
    else
    {
        UIButton *qualifyOrder = (UIButton*) [cell viewWithTag:105];
        [qualifyOrder setTitle:@"" forState:UIControlStateNormal];
     
    }
    
    
    return cell;
}

@end
