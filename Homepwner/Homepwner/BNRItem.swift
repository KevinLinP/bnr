//
//  BNRItem.swift
//  Homepwner
//
//  Created by Kevin Lin on 6/2/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

import Foundation

@objc class BNRItem: NSObject, NSCoding {
    
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
    
    convenience required init(coder aCoder: NSCoder) {
        let itemName = aCoder.decodeObjectForKey("itemName") as! String
        let valueInDollars = aCoder.decodeIntegerForKey("valueInDollars")
        let serialNumber = aCoder.decodeObjectForKey("serialNumber") as! String
        let dateCreated = aCoder.decodeObjectForKey("dateCreated") as! NSDate
        let itemKey = aCoder.decodeObjectForKey("itemKey") as! String
        
        self.init(fromItemName: itemName, valueInDollars: valueInDollars, serialNumber: serialNumber, dateCreated: dateCreated, itemKey: itemKey)
    }
    
    convenience init(fromItemName: NSString, valueInDollars: Int, serialNumber: NSString) {
        self.init(fromItemName: fromItemName, valueInDollars: valueInDollars, serialNumber: serialNumber, dateCreated: NSDate(), itemKey: NSUUID().UUIDString)
    }
    
    convenience init(fromItemName: NSString) {
        self.init(fromItemName: fromItemName, valueInDollars: 0, serialNumber: "")
    }
    
    override convenience init() {
        self.init(fromItemName: "Item")
    }
    
    /*
    convenience init(random: Bool) {
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        let randomNounList = ["Bear", "Spork", "Mac"]
        
        let adjectiveIndex = Integer.random() % randomAdjectiveList.count
        let nounIndex = Integer.random() % randomNounList.count
        
        let randomName = NSString(format:"%@ %@", randomAdjectiveList[adjectiveIndex], randomAdjectiveList[nounIndex]);
        
        let zero: Character = "0"
        let a: Character = "A"
        
        let randomValue = arc4random() % 100
        let randomSerialNumber = String(format:"%c%c%c%c%c",
            zero + arc4random() % 26,
            a + arc4random() % 26,
            zero + arc4random() % 10,
            a + arc4random() % 26,
            zero + arc4random() % 10);
        
        self.init(fromItemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
    }
*/
    
    func itemDescription() -> NSString {
        let descriptionString = NSString(format:"%@ (%@): Worth $%d, recorded on %@",
            self.itemName,
            self.serialNumber,
            self.valueInDollars,
            self.dateCreated)
        
        return descriptionString
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.itemName, forKey: "itemName")
        aCoder.encodeObject(self.serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(self.dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(self.itemKey, forKey: "itemKey")
        aCoder.encodeInteger(self.valueInDollars, forKey: "valueInDollars")
    }
    
    
}