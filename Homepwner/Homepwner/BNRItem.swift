//
//  BNRItem.swift
//  Homepwner
//
//  Created by Kevin Lin on 6/2/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit

@objc class BNRItem: NSObject, NSCoding {
    
    var itemName, serialNumber, itemKey: String
    var valueInDollars: Int
    var dateCreated: NSDate
    var thumbnail: UIImage?
    
    init(fromItemName: String, valueInDollars: Int, serialNumber: String, dateCreated: NSDate, itemKey: String) {
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
    
    convenience init(fromItemName: String, valueInDollars: Int, serialNumber: String) {
        self.init(fromItemName: fromItemName, valueInDollars: valueInDollars, serialNumber: serialNumber, dateCreated: NSDate(), itemKey: NSUUID().UUIDString)
    }
    
    convenience init(fromItemName: String) {
        self.init(fromItemName: fromItemName, valueInDollars: 0, serialNumber: "")
    }
    
    override convenience init() {
        self.init(fromItemName: "Item")
    }
    
    
    convenience init(random: Bool) {
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        let randomNounList = ["Bear", "Spork", "Mac"]
        
        let adjectiveIndex = Int(arc4random_uniform(3));
        let nounIndex = Int(arc4random_uniform(3));
        
        let randomName = String(format:"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]);
        
        let a = 65;
        
        let randomValue = Int(arc4random()) % 100
        let randomSerialNumber = String(format:"%d%@%d%@%d",
            Int(arc4random_uniform(10)),
            String(UnicodeScalar(a + (Int(arc4random()) % 26))),
            Int(arc4random_uniform(10)),
            String(UnicodeScalar(a + (Int(arc4random()) % 26))),
            Int(arc4random_uniform(10)))
    
        
        self.init(fromItemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
    }
    
    func itemDescription() -> String {
        let descriptionString = String(format:"%@ (%@): Worth $%d, recorded on %@",
            self.itemName,
            self.serialNumber,
            self.valueInDollars,
            self.dateCreated)
        
        return descriptionString
    }
    
    func setThumbnailFromImage(image: UIImage) {
        let originalSize = image.size
        let newRect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let ratio = max(newRect.width/originalSize.width, newRect.height/originalSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newRect.size, false, 0.0)
        let path = UIBezierPath(roundedRect: newRect, cornerRadius: 5.0)
        path.addClip()
        
        let width = ratio * originalSize.width
        let height = ratio * originalSize.height
        let x = ((newRect.size.width - width) / 2.0)
        let y = ((newRect.size.height - height) / 2.0)
        let projectRect = CGRect(x: x, y: y, width: width, height: height)
        
        image.drawInRect(projectRect)
        
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        self.thumbnail = smallImage
        
        UIGraphicsEndImageContext()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.itemName, forKey: "itemName")
        aCoder.encodeObject(self.serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(self.dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(self.itemKey, forKey: "itemKey")
        aCoder.encodeInteger(self.valueInDollars, forKey: "valueInDollars")
    }
    
    
}