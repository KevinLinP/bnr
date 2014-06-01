//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Kevin Lin on 4/28/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
- (NSString *)imagePathForKey:(NSString *)key;

@end
