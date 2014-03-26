//
//  BNRContainer.h
//  RandomItems
//
//  Created by Kevin Lin on 2/22/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//


#import "BNRItem.h"

@interface BNRContainer : BNRItem
{
    NSMutableArray *_subitems;
}

- (NSMutableArray *)subitems;

- (void)addItem:(BNRItem *)item;


@end

//        BNRContainer *smallContainer = [[BNRContainer alloc] initWithItemName:@"Box"
//                                                          valueInDollars:10
//                                                            serialNumber:@"abc"];
//
//        for(int i = 0; i < 3; i++) {
//            [smallContainer addItem:[BNRItem randomItem]];
//        }
//
//
//        BNRContainer *largeContainer = [[BNRContainer alloc] initWithItemName:@"Chest"
//                                                               valueInDollars:100
//                                                                 serialNumber:@"xyz"];
//        [largeContainer addItem:smallContainer];
//        for(int i = 0; i < 2; i++) {
//            [largeContainer addItem:[BNRItem randomItem]];
//        }
//
//        NSLog(@"%@", largeContainer);
//        largeContainer = nil;