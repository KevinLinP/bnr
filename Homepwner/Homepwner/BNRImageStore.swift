//
//  BNRImageStore.swift
//  Homepwner
//
//  Created by Kevin Lin on 6/10/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit

var _sharedBNRImageStore : BNRImageStore?

@objc class BNRImageStore: NSObject {
    
    let dictionary = NSMutableDictionary()
    
    init(isPrivate: Bool) {
        super.init()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: "clearCache:", name: "UIApplicationDidReceiveMemoryWarningNotification", object: nil)
    }
    
    class func sharedStore() -> BNRImageStore {
        if _sharedBNRImageStore == nil {
            _sharedBNRImageStore = BNRImageStore(isPrivate: true)
        }
        
        return _sharedBNRImageStore!
    }
    
    func setImage(image: UIImage, key: String) {
        self.dictionary[key] = image
        
        let imagePath = self.imagePath(key)
        let data = UIImageJPEGRepresentation(image, 0.5)
        
        data.writeToFile(imagePath, atomically: true)
    }
    
    func imageForKey(key: String) -> UIImage? {
        var result = self.dictionary[key] as! UIImage?
        
        if (result == nil) {
            let imagePath = self.imagePath(key)
            result = UIImage(contentsOfFile: imagePath)
            
            if (result != nil) {
                self.dictionary[key] = result
            } else {
                NSLog(" Error: unable to find %@", imagePath);
            }
        }
        
        return result
    }
    
    func deleteImage(key: String) {
        self.dictionary.removeObjectForKey(key)
        
        let imagePath = self.imagePath(key)
        NSFileManager.defaultManager().removeItemAtPath(imagePath, error: nil)
    }
    
    func imagePath(key: String) -> String {
        let documentDirectories = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentDirectory = documentDirectories[0] as! String
        
        return documentDirectory.stringByAppendingPathComponent(key)
    }
    
    func clearCache(note: NSNotification) {
        NSLog("flushing %d images out of the cache", self.dictionary.count)
        self.dictionary.removeAllObjects()
    }
    
}

/*
//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Kevin Lin on 4/28/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

#pragma mark - initializers

+ (instancetype)sharedStore
{
static BNRImageStore *sharedStore = nil;

static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
sharedStore = [[self alloc] initPrivate];
});

return sharedStore;
}

- (instancetype)init
{
@throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
return nil;
}

- (instancetype)initPrivate
{
self = [super init];
if (self) {
_dictionary = [[NSMutableDictionary alloc] init];

NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
[nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}
return self;
}

#pragma mark - actions

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
self.dictionary[key] = image;

NSString *imagePath = [self imagePathForKey:key];
NSData *data = UIImageJPEGRepresentation(image, 0.5);
[data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
UIImage *result =  self.dictionary[key];

if (!result) {
NSString *imagePath = [self imagePathForKey:key];
result = [UIImage imageWithContentsOfFile:imagePath];

if (result) {
self.dictionary[key] = result;
} else {
NSLog(@"Error: uanble to find %@", [self imagePathForKey:key]);
}
}

return result;
}

- (void)deleteImageForKey:(NSString *)key
{
if (!key) {
return;
}
[self.dictionary removeObjectForKey:key];

NSString *imagePath = [self imagePathForKey:key];
[[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

#pragma mark - helpers

- (NSString *)imagePathForKey:(NSString *)key
{
NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *documentDirectory = [documentDirectories firstObject];

return [documentDirectory stringByAppendingPathComponent:key];
}

- (void)clearCache:(NSNotification *)note
{
NSLog(@"flushing %d images out of the cache", [self.dictionary count]);
[self.dictionary removeAllObjects];
}

@end
*/

