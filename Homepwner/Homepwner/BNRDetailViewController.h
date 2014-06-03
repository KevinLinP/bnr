//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Kevin Lin on 4/19/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Homepwner-Swift.h"

@interface BNRDetailViewController : UIViewController

- (instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
