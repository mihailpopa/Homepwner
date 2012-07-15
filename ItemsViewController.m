//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Mihai Popa on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "DetailViewController.h"

@implementation ItemsViewController
-(id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        for (int i = 0 ; i < 15; i++)
        {
            //[[BNRItemStore sharedStore] createItem];
        }
        UINavigationItem *navItem = [self navigationItem];
        [navItem setTitle:@"Homepwner"];
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        [[self navigationItem] setRightBarButtonItem:bbi];
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *clr = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        clr  = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
    }else {
        clr = [UIColor groupTableViewBackgroundColor];
    }
    [[self view] setBackgroundColor:clr];
}
-(id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}
/*
-(UIView*)headerView
{
    if (!headerView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return headerView;
}

-(void)toggleEditingMode:(id)sender
{
    if ([self isEditing])
    {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}
-(IBAction)addNewItem:(id)sender
{
    //Make a new index path for the 0th section, last row
    //int lastRow = [[self tableView] numberOfRowsInSection:1];
    
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    //int lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    //NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    //Insert this new row into the table
    //[[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationTop];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:YES];
    [detailViewController setItem:newItem];
    [detailViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }]; 
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    [navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:navController animated:YES completion:nil];
}

// UITableViewDataSource protocol
//

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];

if (!cell)
{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
}

    BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[p description]];

return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        //Remove the record from the data source
        
        BNRItemStore *ps = [BNRItemStore sharedStore];
        NSArray *items = [ps allItems];
        BNRItem *p = [items objectAtIndex:[indexPath row]];
        [ps removeItem:p];
    
        //Remove the row
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
}


// UITableViewDelegate methods
//
/*
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [[self headerView] bounds].size.height;
}
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:NO];
    NSArray *items =  [[BNRItemStore sharedStore]allItems];
    BNRItem *selectedItem = [items objectAtIndex:[indexPath row]];
    [detailViewController setItem:selectedItem];
    [[self navigationController] pushViewController:detailViewController animated:YES];
}
@end
