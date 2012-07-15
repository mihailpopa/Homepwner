//
//  DetailViewController.h
//  Homepwner
//
//  Created by Mihai Popa on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface DetailViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIPopoverControllerDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    
    UIPopoverController *imagePickerPopover;
}
- (id)initForNewItem:(BOOL)isNew;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)takePicture:(id)sender;
-(void)save:(id)sender;

@property (strong, nonatomic) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
