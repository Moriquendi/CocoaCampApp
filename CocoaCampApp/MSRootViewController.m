//
//  MSRootViewController.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSRootViewController.h"
#import "MSCurrencyInfoCollectionViewCell.h"
#import "MSConvertedCurrencyTableViewCell.h"
#import "MSCurrencySummaryViewController.h"
#import "MSDataCurrency.h"

#define THUMB_SIZE              44
#define TABLE_VIEW_CELL_HEIGHT  90

NSString *const kCurrencyInfoCellIdentifier = @"cinfo";
NSString *const kConvertedCurrencyCellIdentifier = @"ccc";

@interface MSRootViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *currenciesCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *convertedCurrenciesTableView;

@property (strong, nonatomic) NSNumberFormatter *currencyFormatter;
@property (nonatomic, strong) NSArray *currencies; // of MSDataCurrency
@property (nonatomic, strong) NSMutableArray *selectedCurrenciesIndexes;

@end

@implementation MSRootViewController

#pragma mark - UIViewController

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

    // Setting up table view
    [self.convertedCurrenciesTableView registerClass:[MSConvertedCurrencyTableViewCell class]
                              forCellReuseIdentifier:kConvertedCurrencyCellIdentifier];
    
    // Setting up collection view
    [self.currenciesCollectionView registerClass:[MSCurrencyInfoCollectionViewCell class]
                      forCellWithReuseIdentifier:kCurrencyInfoCellIdentifier];
    self.currenciesCollectionView.allowsMultipleSelection = YES;

    self.selectedCurrenciesIndexes = [[NSMutableArray alloc] init];

    // Test data
    NSMutableArray *currencies = [[NSMutableArray alloc] initWithCapacity:4];
    [currencies addObject:[[MSDataCurrency alloc] initWithDollarRatio:1.4]];
    [currencies addObject:[[MSDataCurrency alloc] initWithDollarRatio:2.0]];
    [currencies addObject:[[MSDataCurrency alloc] initWithDollarRatio:2.7]];
    [currencies addObject:[[MSDataCurrency alloc] initWithDollarRatio:5.0]];
    self.currencies = currencies;
}

#pragma mark - MSRootViewController

- (void)doneButtonTapped
{
    [self.amountTextField resignFirstResponder];
    [self convert];
}

- (void)convert
{
    [self.convertedCurrenciesTableView reloadRowsAtIndexPaths:[self.convertedCurrenciesTableView indexPathsForVisibleRows]
                                             withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.selectedCurrenciesIndexes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kConvertedCurrencyCellIdentifier];

    if ([cell isKindOfClass:[MSConvertedCurrencyTableViewCell class]]) {
        MSConvertedCurrencyTableViewCell *currencyCell = (MSConvertedCurrencyTableViewCell *)cell;
        NSUInteger currencyIndex = [self.selectedCurrenciesIndexes[indexPath.row] intValue];
        MSDataCurrency *currencyData = [self.currencies objectAtIndex:currencyIndex];
        NSNumber *amount = @([self.amountTextField.text intValue] * currencyData.toDollarRatio);

        currencyCell.amount = [NSNumberFormatter localizedStringFromNumber:amount
                                                               numberStyle:NSNumberFormatterCurrencyStyle];
    }

    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_VIEW_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSCurrencySummaryViewController *currencySummaryVC = [[MSCurrencySummaryViewController alloc] init];
    [self.navigationController pushViewController:currencySummaryVC animated:YES];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.currencies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCurrencyInfoCellIdentifier
                                                                           forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedCurrenciesIndexes addObject:@(indexPath.item)];

    [self.convertedCurrenciesTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                     withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedCurrenciesIndexes removeObject:@(indexPath.item)];

    [self.convertedCurrenciesTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                     withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
