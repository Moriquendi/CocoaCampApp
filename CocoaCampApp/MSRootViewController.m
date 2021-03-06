//
//  MSRootViewController.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSRootViewController.h"
#import "MSConvertedCurrencyTableViewCell.h"
#import "MSCurrencySummaryViewController.h"
#import "MSDataCurrency.h"
#import "MSStyleSheet.h"
#import "MSClient.h"

#define THUMB_SIZE                         44
#define TABLE_VIEW_CELL_HEIGHT             90
#define SOURCE_CURRENCY_TAG                1
#define DESTINATION_CURRENCY_TAG           2

NSString *const kConvertedCurrencyCellIdentifier = @"ccc";

@interface MSRootViewController ()

@property (weak, nonatomic) IBOutlet UILabel *sourceCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationCurrencyLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITableView *convertedCurrenciesTableView;
@property (nonatomic, readwrite, strong) NSArray *currencies; // of MSDataCurrency
@property (strong, nonatomic) NSNumberFormatter *currencyFormatter;
@property (nonatomic, strong) NSMutableArray *selectedCurrenciesIndexes;
@property (nonatomic) NSUInteger sourceCurrencyIndex;

@end

@implementation MSRootViewController

- (void)setSourceCurrencyIndex:(NSUInteger)sourceCurrencyIndex
{
    _sourceCurrencyIndex = sourceCurrencyIndex;
    self.sourceCurrencyLabel.text = [NSString stringWithFormat:@"From %@", [self.currencies[sourceCurrencyIndex] ISOCurrencyCode]];
}

#pragma mark - NSObject

- (id)init
{
    if (self = [super initWithNibName:@"MSRootViewController" bundle:nil]) {
        [self _setup];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Appearance
    MSStyleSheet *styleSheet = [MSStyleSheet sharedInstance];
    self.view.backgroundColor = styleSheet.mainBackgroundColor;
    self.title = NSLocalizedString(@"Converter", nil);
    self.convertedCurrenciesTableView.backgroundColor = styleSheet.mainBackgroundColor;
    self.amountTextField.textColor = styleSheet.darkTextColor;

    // Setting up amount text field's keyboard
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, THUMB_SIZE)];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    keyboardToolbar.items = @[doneButton];

    self.amountTextField.inputAccessoryView = keyboardToolbar;

    // Setting up table view
    [self.convertedCurrenciesTableView registerClass:[MSConvertedCurrencyTableViewCell class]
                              forCellReuseIdentifier:kConvertedCurrencyCellIdentifier];

    [self _updateDestinationLabel];
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

- (IBAction)showCurrenciesPicker:(id)sender
{
    MSCurrencyPickerViewController *currencyPickerVC = [[MSCurrencyPickerViewController alloc] initWithCurrencies:self.currencies];
    currencyPickerVC.delegate = self;
    
    switch ([sender tag]) {
        case SOURCE_CURRENCY_TAG:
            currencyPickerVC.enableMultipleSelection = NO;
            [currencyPickerVC selectItemAtIndex:self.sourceCurrencyIndex];
            currencyPickerVC.title = NSLocalizedString(@"From", nil);
            break;
        case DESTINATION_CURRENCY_TAG:
            currencyPickerVC.enableMultipleSelection = YES;
            for (NSNumber *index in self.selectedCurrenciesIndexes) {
                [currencyPickerVC selectItemAtIndex:[index intValue]];
            }
            currencyPickerVC.title = NSLocalizedString(@"To", nil);
            break;
        default:
            break;
    }
    currencyPickerVC.tag = [sender tag];
    [self presentAccessoryViewController:currencyPickerVC sender:sender];
}
- (IBAction)textDidChange:(id)sender
{
    [self.convertedCurrenciesTableView reloadData];
}

- (IBAction)textFieldFinishedEditing:(id)sender
{
    [self.amountTextField resignFirstResponder];
}

#pragma mark - MSRootViewController ()

- (void)_setup
{
    // Set default source currency
    self.sourceCurrencyIndex = 0;
    
    // Load data
    self.currencies = [[MSClient sharedInstance] currenciesData];
    
    // Selected currencies indexes
    self.selectedCurrenciesIndexes = [[NSMutableArray alloc] init];
    
    // Setting up Currency formatter
    self.currencyFormatter = [[NSNumberFormatter alloc] init];
    [self.currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.currencyFormatter setLocale:[NSLocale currentLocale]];
}

- (void)_updateDestinationLabel
{
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for (NSNumber *idx in self.selectedCurrenciesIndexes) {
        [indexSet addIndex:[idx integerValue]];
    }
    NSArray *currencies = [self.currencies objectsAtIndexes:indexSet];

    NSMutableArray *ISOSymbols = [[NSMutableArray alloc] initWithCapacity:[self.currencies count]];
    for (MSDataCurrency *currency in currencies) {
        [ISOSymbols addObject:currency.ISOCurrencyCode];
    }

    NSString *symbolsText = [ISOSymbols componentsJoinedByString:@", "];
    self.destinationCurrencyLabel.text = [NSString stringWithFormat:@"To %@", symbolsText];
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
        MSDataCurrency *currencyData = self.currencies[currencyIndex];
        MSDataCurrency *currencyFromData = self.currencies[self.sourceCurrencyIndex];
        NSNumber *amount = @0;
        if (currencyData.toDollarRatio != 0) {
            amount = @([self.amountTextField.text intValue] * currencyFromData.toDollarRatio / currencyData.toDollarRatio);
        }

        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setCurrencySymbol:currencyData.currencySymbol];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        currencyCell.amount = [formatter stringFromNumber:amount];
        currencyCell.ISOCurrencySymbol = currencyData.ISOCurrencyCode;
        currencyCell.fullCurrencyName = currencyData.fullName;
    }

    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = [self.selectedCurrenciesIndexes[indexPath.row] integerValue];
    MSCurrencySummaryViewController *currencySummaryVC = [[MSCurrencySummaryViewController alloc] initWithCurrencyData:self.currencies[index]];
    [self.navigationController pushViewController:currencySummaryVC animated:YES];
}
 
#pragma mark - <MSPickerDelegate>

- (void)currencyPicker:(MSCurrencyPickerViewController *)picker didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([picker tag]) {
        case SOURCE_CURRENCY_TAG:
            self.sourceCurrencyIndex = indexPath.item;
            break;
        case DESTINATION_CURRENCY_TAG:
            if (![self.selectedCurrenciesIndexes containsObject:@(indexPath.item)]) {
                [self.selectedCurrenciesIndexes addObject:@(indexPath.item)];
                [self _updateDestinationLabel];
            }
            break;
        default:
            break;
    }

    [self.convertedCurrenciesTableView reloadData];
}

- (void)currencyPicker:(MSCurrencyPickerViewController *)picker didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([picker tag]) {
        case SOURCE_CURRENCY_TAG:
            break;
        case DESTINATION_CURRENCY_TAG:
            [self.selectedCurrenciesIndexes removeObject:@(indexPath.item)];
            [self _updateDestinationLabel];
            break;
        default:
            break;
    }

    [self.convertedCurrenciesTableView reloadData];
}

@end
