//
//  MyOrdersViewController.h
//  Electrodom
//
//  Created by Juan Cambón on 27/10/15.
//  Copyright © 2015 Jacobo Singer. All rights reserved.
//

#import "ViewController.h"

@interface MyOrdersViewController : ViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
