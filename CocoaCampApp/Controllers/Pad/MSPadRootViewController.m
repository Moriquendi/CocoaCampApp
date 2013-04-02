//
//  MSPadRootViewController.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 01.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSPadRootViewController.h"
#import "MSCurrencySummaryViewController.h"

@interface MSPadRootViewController ()
@property (nonatomic, weak) IBOutlet UIView *currencySummaryView;
@property (nonatomic, strong) UIPopoverController *pickerPopover;
@property (nonatomic, strong) UIViewController *summaryVC;
@end

@implementation MSPadRootViewController

#pragma mark - NSObject

- (id)init
{
    if (self = [super initWithNibName:@"MSPadRootViewController" bundle:nil]) {
        // Nothing here
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currencySummaryView.backgroundColor = [UIColor clearColor];
}


#pragma mark - MSRootViewController

- (IBAction)showCurrenciesPicker:(id)sender
{
    MSCurrencyPickerViewController *currencyPickerVC = [[MSCurrencyPickerViewController alloc] initWithCurrencies:self.currencies];
    currencyPickerVC.delegate = self;
    currencyPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
    
    self.pickerPopover = [[UIPopoverController alloc] initWithContentViewController:currencyPickerVC];
    [self.pickerPopover presentPopoverFromRect:((UIView *)sender).frame
                                        inView:[sender superview]
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:YES];

    [self.pickerPopover setPopoverContentSize:self.pickerPopover.contentViewController.contentSizeForViewInPopover
                                     animated:YES];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *childView in self.currencySummaryView.subviews) {
        [childView removeFromSuperview];
    }
    
    [self.summaryVC removeFromParentViewController];
    self.summaryVC = [[MSCurrencySummaryViewController alloc] init];
    
    [self addChildViewController:self.summaryVC];
    [self.currencySummaryView addSubview:self.summaryVC.view];
    self.summaryVC.view.frame = self.currencySummaryView.bounds;
}

@end
