//
//  BNRItemsViewController.swift
//  Homepwner
//
//  Created by Kevin Lin on 7/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BNRItemsViewController: UITableViewController,UITableViewDataSource, UITableViewDelegate {
    
    init() {
        super.init(style: UITableViewStyle.Plain);
        
        let bbi = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewItem:");
        
        let navItem = self.navigationItem;
        navItem.title = "Homepwnr";
        navItem.leftBarButtonItem = self.editButtonItem();
        navItem.rightBarButtonItem = bbi;
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        tableView.reloadData();
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell;
        
        let item = itemAtIndexPath(indexPath);
        cell.textLabel?.text = item.itemDescription() as String;
        
        return cell;
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> BNRItem {
        let items = BNRItemStore.sharedStore().allItems();
        return items[indexPath.row] as! BNRItem;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.sharedStore().allItems().count;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let items = BNRItemStore.sharedStore().allItems();
            let item = items[indexPath.row] as! BNRItem;
            
            BNRItemStore.sharedStore().removeItem(item);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right);
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        BNRItemStore.sharedStore().moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row);
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = BNRDetailViewController(newItem: false);
        detailViewController.item = itemAtIndexPath(indexPath);
        
        self.navigationController?.pushViewController(detailViewController, animated: true);
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = BNRItemStore.sharedStore().createItem();
        
        let detailViewController = BNRDetailViewController(newItem: true);
        detailViewController.item = newItem;
        detailViewController.dismissBlock = {
            self.tableView.reloadData();
        }
        
        let navController = UINavigationController(rootViewController: detailViewController);
        navController.modalPresentationStyle = UIModalPresentationStyle.FormSheet;
        
        self.presentViewController(navController, animated: true, completion: nil);
    }
}





/*
//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Kevin Lin on 4/18/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
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
    cell.textLabel.text = item.itemDescription;
    
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
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initWithNewItem:NO];
    detailViewController.item = [self itemAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - actions

- (IBAction)addNewItem:(id)sender
{
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initWithNewItem:YES];
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
*/