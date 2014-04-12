//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Kevin Lin on 4/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
}

@end
