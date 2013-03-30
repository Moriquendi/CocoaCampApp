//
//  MSRootViewController.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSRootViewController.h"

#define THUMB_SIZE  44

@interface MSRootViewController ()
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (strong, nonatomic) NSNumberFormatter *currencyFormatter;
@end

@implementation MSRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setting up Currency formatter
    self.currencyFormatter = [[NSNumberFormatter alloc] init];
    [self.currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.currencyFormatter setLocale:[NSLocale currentLocale]];

    // Setting up amount text field's keyboard
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];

    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, THUMB_SIZE)];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    keyboardToolbar.items = @[doneButton];

    self.amountTextField.inputAccessoryView = keyboardToolbar;
}

- (void)doneButtonTapped
{
    [self.amountTextField resignFirstResponder];
    [self convert];
}

- (void)convert
{
    NSNumber *num = @([self.amountTextField.text intValue]);
    NSLog(@"%@", [NSNumberFormatter localizedStringFromNumber:num numberStyle:NSNumberFormatterCurrencyStyle]);
}

@end
