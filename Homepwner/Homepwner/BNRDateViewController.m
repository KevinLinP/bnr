//
//  BNRDateViewController.m
//  Homepwner
//
//  Created by Kevin Lin on 4/21/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDateViewController.h"

@interface BNRDateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDateViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.date = self.item.dateCreated;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.item.dateCreated = self.datePicker.date;
}

@end