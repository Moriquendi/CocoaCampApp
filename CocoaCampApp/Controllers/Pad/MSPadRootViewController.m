//
//  MSPadRootViewController.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 01.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSPadRootViewController.h"
#import "MSCurrencySummaryViewController.h"
#import "MSRootViewController_Private.h"

@interface MSPadRootViewController ()
@property (nonatomic, weak) IBOutlet UIView *currencySummaryView;
@property (nonatomic, strong) UIViewController *summaryVC;
@end

@implementation MSPadRootViewController

#pragma mark - NSObject

- (id)init
{
    if (self = [super initWithNibName:@"MSPadRootViewController" bundle:nil]) {
        [self _setup];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currencySummaryView.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *childView in self.currencySummaryView.subviews) {
        [childView removeFromSuperview];
    }
    
    [self.summaryVC removeFromParentViewController];
    self.summaryVC = [[MSCurrencySummaryViewController alloc] initWithCurrencyData:self.currencies[indexPath.row]];
    
    [self addChildViewController:self.summaryVC];
    [self.currencySummaryView addSubview:self.summaryVC.view];
    self.summaryVC.view.frame = self.currencySummaryView.bounds;
}

@end
