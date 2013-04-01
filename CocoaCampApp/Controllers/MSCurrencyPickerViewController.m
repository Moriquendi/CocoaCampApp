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
@property (nonatomic, strong) NSArray *currencies;
@end

@implementation MSCurrencyPickerViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // TODO: Put in stylesheet
    self.collectionView.backgroundColor = [UIColor colorWithWhite:70.f/255.f alpha:0.3];
    self.collectionView.layer.borderColor = [[MSStyleSheet sharedInstance].separatorColor CGColor];
    self.collectionView.layer.borderWidth = 2.0;
    self.collectionView.layer.cornerRadius = 5.0;
    
    // Setting up collection view
    [self.collectionView registerClass:[MSCurrencyInfoCollectionViewCell class]
                      forCellWithReuseIdentifier:kCurrencyInfoCellIdentifier];
    self.collectionView.allowsMultipleSelection = YES;
}

#pragma mark - MSCurrencyPickerViewController

- (id)initWithCurrencies:(NSArray *)currencies
{
    // TODO:
//    if (self = [super initWithNibName:@"MSCurrencyPickerViewController" bundle:nil]) {
    if (self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
        self.currencies = currencies;
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

- (void)currencyPicker:(MSCurrencyPickerViewController *)picker didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.delegate respondsToSelector:@selector(currencyPicker:didDeselectItemAtIndexPath::)]) {
        [self.delegate currencyPicker:self didDeselectItemAtIndexPath:indexPath];
    }
}

@end
