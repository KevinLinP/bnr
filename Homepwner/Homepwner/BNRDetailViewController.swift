//
//  BNRDetailViewController.swift
//  Homepwner
//
//  Created by Kevin Lin on 6/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit

var sharedDateFormatter = NSDateFormatter()

@objc(BNRDetailViewController) @IBDesignable class BNRDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate {
    
    var item: BNRItem? {
    didSet {
        self.navigationItem.title = item!.itemName as String
    }
    }
    
    var dateFormatter: NSDateFormatter {
    get {
        let dateFormatter = sharedDateFormatter
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        return dateFormatter
    }
    }
    
    var imagePickerPopover: UIPopoverController?
    @IBOutlet weak var nameField: UITextField?
    @IBOutlet weak var serialNumberField: UITextField?
    @IBOutlet weak var valueField: UITextField?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var toolbar: UIToolbar?
    @IBOutlet weak var cameraButton: UIBarButtonItem?
    var dismissBlock: () -> Void = { return } // I don't know how to have an optional anonymous function
    
    init(newItem: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        if (newItem) {
            let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target:self, action: "save:")
            let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel:")
            
            self.navigationItem.rightBarButtonItem = doneItem
            self.navigationItem.leftBarButtonItem = cancelItem
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let io = UIApplication.sharedApplication().statusBarOrientation
        self.prepareViews(io)
        
        let item = self.item!
        
        self.nameField!.text = item.itemName
        self.serialNumberField!.text = item.serialNumber as String
        self.valueField!.text = "\(item.valueInDollars)"
        self.dateLabel!.text = self.dateFormatter.stringFromDate(item.dateCreated)
        
        if let imageToDisplay = BNRImageStore.sharedStore().imageForKey(item.itemKey as String) {
            self.imageView!.image = imageToDisplay
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iv = UIImageView()
        iv.contentMode = UIViewContentMode.ScaleAspectFit
        iv.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(iv)
        self.imageView = iv
    
        let nameMap: [String: UIView] = ["imageView": self.imageView!, "dateLabel": self.dateLabel!, "toolbar": self.toolbar!]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: nameMap)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[dateLabel]-[imageView]-[toolbar]", options: NSLayoutFormatOptions(0), metrics: nil, views: nameMap)
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        
        iv.setContentHuggingPriority(200, forAxis: UILayoutConstraintAxis.Vertical)
        iv.setContentCompressionResistancePriority(700, forAxis: UILayoutConstraintAxis.Vertical)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        
        let item = self.item!
        item.itemName = self.nameField!.text
        item.serialNumber = self.serialNumberField!.text
        item.itemName = self.nameField!.text
        if let dollars = self.valueField!.text.toInt() {
            item.valueInDollars = dollars
        }
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.prepareViews(toInterfaceOrientation)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
            item!.setThumbnailFromImage(image)
        
            self.imageView!.image = image
            BNRImageStore.sharedStore().setImage(image, key: self.item!.itemKey as String)
            
            if let imagePickerPopover = self.imagePickerPopover {
                imagePickerPopover.dismissPopoverAnimated(true)
                self.imagePickerPopover = nil
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        NSLog("User dismissed popover")
        self.imagePickerPopover = nil
    }
    
    func backgroundTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
  
    func takePicture(sender: AnyObject) {
        if let imagePickerPopover = self.imagePickerPopover {
            if imagePickerPopover.popoverVisible {
                imagePickerPopover.dismissPopoverAnimated(true)
                self.imagePickerPopover = nil
                return
            }
        }
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            self.imagePickerPopover = UIPopoverController(contentViewController: imagePicker)
            self.imagePickerPopover!.delegate = self
            self.imagePickerPopover!.presentPopoverFromBarButtonItem(sender as! UIBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        } else {
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func save(sender: AnyObject) {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: self.dismissBlock)
    }
    
    func cancel(sender: AnyObject) {
        BNRItemStore.sharedStore().removeItem(self.item!)
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: self.dismissBlock)
    }
    
    func prepareViews(orientation: UIInterfaceOrientation) {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            return
        }
        
        if UIInterfaceOrientationIsLandscape(orientation) {
            self.imageView!.hidden = true
            self.cameraButton!.enabled = false
        } else {
            self.imageView!.hidden = false
            self.cameraButton!.enabled = true
        }
    }
    
    
}