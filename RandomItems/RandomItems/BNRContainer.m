//
//  BNRContainer.m
//  RandomItems
//
//  Created by Kevin Lin on 2/22/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (instancetype)initWithItemName: (NSString *)name
                  valueInDollars: (int)value
                    serialNumber: (NSString *)sNumber
{
    self = [super initWithItemName:name
                    valueInDollars:value
                      serialNumber:sNumber];
    
    if (self) {
        _subitems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSMutableArray *)subitems
{
    return _subitems;
}

- (void)addItem:(BNRItem *)item
{
    [self.subitems addObject:item];
}

- (int)valueInDollars
{
    int totalValue = self.valueInDollars;
    
    for (BNRItem *item in self.subitems) {
        totalValue += item.valueInDollars;
    }
    
    return totalValue;
}


- (NSString *)description
{
    NSString *containerDescription = [super description];
    NSMutableString *descriptionString = [[NSMutableString alloc] init];
    [descriptionString appendString:containerDescription];
    
    for (BNRItem *item in self.subitems) {
        [descriptionString appendString:@"\n- "];
        [descriptionString appendString:item.description];
    }
    
    return descriptionString;
}

@end
