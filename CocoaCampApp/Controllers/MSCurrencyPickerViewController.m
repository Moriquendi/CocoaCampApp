//
//  MSCurrencyPickerViewController.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 01.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSCurrencyPickerViewController.h"
#import "MSStyleSheet.h"
#import "MSCurrencyInfoCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

NSString *const kCurrencyInfoCellIdentifier = @"cinfo";

@interface MSCurrencyPickerViewController ()
@property (nonatomic, readwrite, strong) NSArray *currencies;
@end

@implementation MSCurrencyPickerViewController

- (void)setEnableMultipleSelection:(BOOL)enableMultipleSelection
{
    _enableMultipleSelection = enableMultipleSelection;
    self.collectionView.allowsMultipleSelection = enableMultipleSelection;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // TODO: Put in stylesheet
    self.collectionView.backgroundColor = [[MSStyleSheet sharedInstance] mainBackgroundColor];
    self.collectionView.layer.borderColor = [[MSStyleSheet sharedInstance].separatorColor CGColor];
//    self.collectionView.layer.borderWidth = 2.0;
//    self.collectionView.layer.cornerRadius = 5.0;
    
    // Setting up collection view
    [self.collectionView registerClass:[MSCurrencyInfoCollectionViewCell class]
                      forCellWithReuseIdentifier:kCurrencyInfoCellIdentifier];
    self.collectionView.allowsMultipleSelection = self.isMultipleSelectionEnabled;
}

#pragma mark - MSCurrencyPickerViewController

- (id)initWithCurrencies:(NSArray *)currencies
{
    if (self = [super initWithNibName:@"MSCurrencyPickerViewController" bundle:nil]) {
        self.currencies = currencies;
        self.enableMultipleSelection = NO;
        self.tag = 0;
    }
    return self;
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
    
    // Configure appearance
    cell.layer.cornerRadius = 5.0;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(currencyPicker:didSelectItemAtIndexPath:)]) {
        [self.delegate currencyPicker:self didSelectItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(currencyPicker:didDeselectItemAtIndexPath:)]) {
        [self.delegate currencyPicker:self didDeselectItemAtIndexPath:indexPath];
    }
}

@end
