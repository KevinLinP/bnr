//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Kevin Lin on 3/26/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet BNRHypnosisView *hypnosisView;

@end

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = i;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:self.view.frame];
    self.hypnosisView = backgroundView;
    
    [self.view insertSubview:backgroundView belowSubview:self.segmentedControl];
    
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (IBAction)changeColor:(id)sender
{
    UIColor *color;
    
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            color = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
            break;
        case 1:
            color = [[UIColor alloc] initWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
            break;
        case 2:
            color = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
            break;
    }
    
    self.hypnosisView.circleColor = color;
}

@end
