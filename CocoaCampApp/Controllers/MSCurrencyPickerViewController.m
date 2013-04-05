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
#import "MSDataCurrency.h"
#import <QuartzCore/QuartzCore.h>

NSString *const kCurrencyInfoCellIdentifier = @"cinfo";

@interface MSCurrencyPickerViewController ()
@property (nonatomic, readwrite, strong) NSArray *currencies;
@property (nonatomic, strong) NSMutableArray *selectedItemIndexes;
@end

@implementation MSCurrencyPickerViewController

#pragma mark - Setters

- (void)setEnableMultipleSelection:(BOOL)enableMultipleSelection
{
    _enableMultipleSelection = enableMultipleSelection;
    self.collectionView.allowsMultipleSelection = enableMultipleSelection;
}

#pragma mark - NSObject

- (void)dealloc
{
    [self.currencies removeObserver:self
               fromObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.currencies count])]
                         forKeyPath:@"isDownloadingRates"];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [[MSStyleSheet sharedInstance] mainBackgroundColor];
    self.collectionView.layer.borderColor = [[MSStyleSheet sharedInstance].separatorColor CGColor];

    // Setting up collection view
    [self.collectionView registerClass:[MSCurrencyInfoCollectionViewCell class]
                      forCellWithReuseIdentifier:kCurrencyInfoCellIdentifier];
    self.collectionView.allowsMultipleSelection = self.isMultipleSelectionEnabled;

    for (NSNumber *index in self.selectedItemIndexes) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:[index intValue] inSection:0]
                                          animated:NO
                                    scrollPosition:UICollectionViewScrollPositionNone];
    }
}

#pragma mark - MSCurrencyPickerViewController

- (id)initWithCurrencies:(NSArray *)currencies
{
    if (self = [super initWithNibName:@"MSCurrencyPickerViewController" bundle:nil]) {
        self.currencies = currencies;
        self.enableMultipleSelection = NO;
        self.selectedItemIndexes = [[NSMutableArray alloc] init];
        self.tag = 0;
        
        // Observer
        [self.currencies addObserver:self
                  toObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.currencies count])]
                          forKeyPath:@"isDownloadingRates"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
    }
    return self;
}

- (void)selectItemAtIndex:(NSUInteger)index
{
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
    [self.selectedItemIndexes addObject:@(index)];
}

- (void)deselectItemAtIndex:(NSUInteger)index
{
    [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                                        animated:NO];
    [self.selectedItemIndexes removeObject:@(index)];
}

#pragma mark - Observers

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isDownloadingRates"]) {
        [self.collectionView reloadItemsAtIndexPaths:@[
         [NSIndexPath indexPathForItem:[self.currencies indexOfObject:object] inSection:0]]];
    };
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.currencies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSCurrencyInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCurrencyInfoCellIdentifier
                                                                                       forIndexPath:indexPath];
    
    MSDataCurrency *currencyData = self.currencies[indexPath.item];

    [cell setCurrencyFullName:currencyData.fullName];
    [cell setCurrencySymbol:currencyData.currencySymbol];
    [cell setEnabled:![currencyData isDownloadingRates]];

    // Configure appearance
    cell.layer.cornerRadius = 5.0;
    cell.layer.masksToBounds = YES;
    
    if ([self.selectedItemIndexes containsObject:@(indexPath.item)]) {
        [cell setSelected:YES];
    }
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return ![self.currencies[indexPath.item] isDownloadingRates];
}

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
