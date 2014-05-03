//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Kevin Lin on 4/19/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:item.itemKey];
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImage *image = [UIImage imageNamed:@"crosshair.png"];
        CGSize frameSize = imagePicker.view.frame.size;
        CGSize imageSize = image.size;
        CGFloat x = (frameSize.width / 2) - (imageSize.width / 2);
        CGFloat y = (frameSize.height / 2) - (imageSize.height / 2);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(x, y, imageSize.width, imageSize.height);
        imagePicker.cameraOverlayView = imageView;
    
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageView.image = image;
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)clearImage:(id)sender {
    self.imageView.image = NULL;
    [[BNRImageStore sharedStore] deleteImageForKey:self.item.itemKey];
}

@end
