//
//  DetailViewController.m
//  Homepwner
//
//  Created by Mihai Popa on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize item;
@synthesize dismissBlock;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"User initForNewItem:" userInfo:nil];
    return nil;
}

- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    if (self)
    {
        if (isNew){
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    return self;
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
-(void)setItem:(BNRItem *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *clr = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        clr  = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
    }else {
        clr = [UIColor groupTableViewBackgroundColor];
    }
    [[self view] setBackgroundColor:clr];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [nameField setText:[item itemName]];
    [serialField setText:[item serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];
    
    //Create an NSDateFormatter that will turn a date into a simple date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]];
    
    NSString *imageKey = [item imageKey];
    
    if (imageKey)
    {
        UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
        [imageView setImage:imageToDisplay];
    }else {
        [imageView setImage:nil];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    //Clear first responding!
    
    [[self view] endEditing:YES];
    
    //Save changes to item
    [item setItemName:[nameField text]];
    [item setSerialNumber:[serialField text]];
    [item setValueInDollars:[[valueField text] intValue]];
}
- (void)viewDidUnload
{
    nameField = nil;
    serialField = nil;
    valueField = nil;
    dateLabel = nil;
    imageView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        return YES;
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
    
    
}

- (IBAction)takePicture:(id)sender {
    //clear the bug that destroys the popover while still on screen
    if ([imagePickerPopover isPopoverVisible])
    {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
        return;
    }

    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)
    {
        imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [imagePickerPopover setDelegate:self];
        [imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else {
        
        [self presentViewController:imagePicker animated:YES completion:nil];

    }
    
    
       
    
}

//Image picker delegate method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *oldKey = [item imageKey];
    
    if (oldKey) {
        [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
    }
    
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:img];
    
    //Create a CFUUID object - it knows how to create unique identifier strings
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    
    //Create a string from the UUID
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    //Use the unique ID to set our item's imageKeys
    NSString *key = (__bridge NSString*)newUniqueIDString;
    [item setImageKey:key];
    
    //Store image in the BNRImageStore with this key
    [[BNRImageStore sharedStore] setImage:img forKey:key];
    
    //Release manually any CF pointer
    CFRelease(newUniqueID);
    CFRelease(newUniqueIDString);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
    }
    else
    [self dismissModalViewControllerAnimated:YES];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover");
    imagePickerPopover = nil;
}
-(void)save:(id)sender
{
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}
-(void)cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:item];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}
@end
