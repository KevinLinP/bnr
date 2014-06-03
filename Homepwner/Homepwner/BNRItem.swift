//
//  BNRItem.swift
//  Homepwner
//
//  Created by Kevin Lin on 6/2/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

import Foundation

class BNRItem: NSObject, NSCoding {
    
    var itemName, serialNumber, itemKey: NSString
    var valueInDollars: Int
    var dateCreated: NSDate
    
    init(fromItemName: NSString, valueInDollars: Int, serialNumber: NSString, dateCreated: NSDate, itemKey: NSString) {
        self.itemName = fromItemName
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = dateCreated
        self.itemKey = itemKey
        
        super.init()
    }
    
    @objc(initWithCoder:) convenience init(coder decoder: NSCoder!) {
        let itemName = decoder.decodeObjectForKey("itemName") as String
        // let valueInDollars = decoder.decodeIntForKey("valueInDollars") as Int
        let valueInDollars = 5
        let serialNumber = decoder.decodeObjectForKey("serialNumber") as String
        let dateCreated = decoder.decodeObjectForKey("dateCreated") as NSDate
        let itemKey = decoder.decodeObjectForKey("itemKey") as String
        
        self.init(fromItemName: itemName, valueInDollars: valueInDollars, serialNumber: serialNumber, dateCreated: dateCreated, itemKey: itemKey)
    }
    
    convenience init(fromItemName: NSString, valueInDollars: Int, serialNumber: NSString) {
        self.init(fromItemName: fromItemName, valueInDollars: valueInDollars, serialNumber: serialNumber, dateCreated: NSDate(), itemKey: NSUUID().UUIDString)
    }
    
    convenience init(fromItemName: NSString) {
        self.init(fromItemName: fromItemName, valueInDollars: 0, serialNumber: "")
    }
    
    convenience init() {
        self.init(fromItemName: "Item")
    }
    
    /*
    class func randomItem -> instancetype {
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        let randomNounList = ["Bear", "Spork", "Mac"]
        
        //let adjectiveIndex = random % randomAdjectiveList.count
        let adjectiveIndex = 1
        // let nounIndex = arc4random() % randomNounList.count
        let nounIndex = 2
        
        let randomName = NSString(format:"%@ %@", randomAdjectiveList[adjectiveIndex], randomAdjectiveList[nounIndex]);
        
        let randomValue = arc4random() % 100
        let randomSerialNumber = NSString(format:"%c%c%c%c%c",
        '0' + arc4random() % 10,
        'A' + arc4random() % 26,
        '0' + arc4random() % 10,
        'A' + arc4random() % 26,
        '0' + arc4random() % 10);
        
        BNRItem *newItem = [[BNRItem alloc] initWithItemName:randomName
        valueInDollars:randomValue
        serialNumber:randomSerialNumber];
        return newItem;
    }
    
    

  
    
    - (instancetype)initWithCoder:(NSCoder *)aDecoder
    {
    self = [super init];
    if (self) {
    _itemName = [aDecoder decodeObjectForKey:@"itemName"];
    _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
    _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
    _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
    _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
    }
    
    return self;
    }

*/
    
    func description() -> NSString {
        let descriptionString = NSString(format:"%@ (%@): Worth $%d, recorded on %@",
            self.itemName,
            self.serialNumber,
            self.valueInDollars,
            self.dateCreated)
        
        return descriptionString
    }
    
    func encodeWithCoder(encoder: NSCoder!) {
        encoder.encodeObject(self.itemName, forKey: "itemName")
        encoder.encodeObject(self.serialNumber, forKey: "serialNumber")
        encoder.encodeObject(self.dateCreated, forKey: "dateCreated")
        encoder.encodeObject(self.itemKey, forKey: "itemKey")
        //aCoder.encodeInt(self.valueInDollars., forKey: "valueInDollars")
    }
    
    
}