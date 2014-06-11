//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Kevin Lin on 4/18/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRDetailViewController.h"
#import "Homepwner-Swift.h"

@interface BNRItemsViewController () <UITableViewDataSource, UITableViewDelegate>


@end

@implementation BNRItemsViewController

#pragma mark - initializers

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        
        navItem.title = @"Homepwnr";
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                     target:self
                                                     action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - tableview data source

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    BNRItem *item = [self itemAtIndexPath:indexPath];
    cell.textLabel.text = item.description;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return[[[BNRItemStore sharedStore] allItems] count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        
        [[BNRItemStore sharedStore] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    detailViewController.item = [self itemAtIndexPath:indexPath];
                          
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - actions

- (IBAction)addNewItem:(id)sender
{
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:YES];
    detailViewController.item = newItem;
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - helpers
                          
- (BNRItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    return items[indexPath.row];
}

@end
