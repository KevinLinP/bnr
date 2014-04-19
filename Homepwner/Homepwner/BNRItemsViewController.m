//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Kevin Lin on 4/18/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController () <UITableViewDataSource>
@end

@implementation BNRItemsViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items;
    switch (indexPath.section) {
        case 0:
            items = self.bnrItemsUnder50;
            break;
        case 1:
            items = self.bnrItemsOver50;
            break;
        default:
            @throw [NSException exceptionWithName:@"WTF" reason:@"WTF" userInfo:nil];
            
    }
    BNRItem *item = items[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = item.description;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.bnrItemsUnder50 count];
        case 1:
            return [self.bnrItemsOver50 count];
        default:
            @throw [NSException exceptionWithName:@"WTF" reason:@"WTF" userInfo:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Under $50";
        case 1:
            return @"Over $50";
        default:
            @throw [NSException exceptionWithName:@"WTF" reason:@"WTF" userInfo:nil];
    }
}

- (NSArray *)bnrItemsUnder50
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"valueInDollars < 50"];
    return [[[BNRItemStore sharedStore] allItems] filteredArrayUsingPredicate:predicate];
}

- (NSArray *)bnrItemsOver50
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"valueInDollars >= 50"];
    return [[[BNRItemStore sharedStore] allItems] filteredArrayUsingPredicate:predicate];
}

@end
