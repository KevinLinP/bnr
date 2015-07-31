//
//  BNRItemStore.swift
//  Homepwner
//
//  Created by Kevin Lin on 6/3/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

import Foundation

var _sharedBNRItemStore : BNRItemStore?

@objc class BNRItemStore: NSObject {
    var privateItems : NSMutableArray
    
    init(isPrivate: Bool) {
        let path = BNRItemStore.itemArchivePath()
        let storedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? NSMutableArray
        
        if let items = storedItems {
            self.privateItems = items
        } else {
            self.privateItems = NSMutableArray()
        }
        
        super.init()
    }
    
    class func sharedStore() -> BNRItemStore {
        if _sharedBNRItemStore == nil {
            _sharedBNRItemStore = BNRItemStore(isPrivate: true)
        }
        
        return _sharedBNRItemStore!
    }
    
    func allItems() -> NSArray {
        return privateItems
    }
    
    func createItem() -> BNRItem {
        let item = BNRItem(random: true)
        privateItems.addObject(item)
        return item
    }
    
    func removeItem(item: BNRItem) {
        //let imageStore = BNRImageStore.sharedStore()
        //imageStore.deleteImageForKey(item.itemKey)
        privateItems.removeObject(item)
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if (fromIndex == toIndex) {
            return
        }
        
        let item = privateItems[fromIndex] as! BNRItem
        privateItems.removeObjectIdenticalTo(item)
        privateItems.insertObject(item, atIndex: toIndex)
    }
    
    func saveChanges() -> Bool {
        let path = BNRItemStore.itemArchivePath();
        
        return NSKeyedArchiver.archiveRootObject(self.privateItems, toFile: path)
    }
    
    class func itemArchivePath() -> String {
        let documentDirectories = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentDirectory = documentDirectories[0] as! String
        
        return documentDirectory.stringByAppendingPathComponent("items.archive")
    }

}

