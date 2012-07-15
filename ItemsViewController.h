//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Mihai Popa on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface ItemsViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    //IBOutlet UIView *headerView;
}
//-(UIView*) headerView;
-(IBAction)addNewItem:(id)sender;
//-(IBAction)toggleEditingMode:(id)sender;
@end
