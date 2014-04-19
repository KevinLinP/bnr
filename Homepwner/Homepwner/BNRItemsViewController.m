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

@interface BNRItemsViewController () <UITableViewDataSource, UITableViewDelegate>
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
    
    self.tableView.delegate = self;
    
    UIImage *image = [UIImage imageNamed:@"background.jpg"];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:image];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSString *description;
    
    if (indexPath.row > ([[[BNRItemStore sharedStore] allItems] count] - 1)) {
        description = @"No more items!";
    } else {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        description = item.description;
        
        UIFont *previousFont = cell.textLabel.font;
        cell.textLabel.font = [UIFont fontWithName:previousFont.fontName size:20.0];
    }
    
    cell.textLabel.text = description;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > ([[[BNRItemStore sharedStore] allItems] count] - 1)) {
        return 44.0;
    } else {
        return 60.0;
    }
}
@end
