//
//  MSCurrencyInfoCollectionViewCell.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSCurrencyInfoCollectionViewCell.h"
#import "MSStyleSheet.h"

@interface MSCurrencyInfoCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *currencySymbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UIView *activityView;

@end

@implementation MSCurrencyInfoCollectionViewCell

#pragma mark - Setters

- (void)setCurrencySymbol:(NSString *)currencySymbol
{
    _currencySymbol = currencySymbol;
    self.currencySymbolLabel.text = _currencySymbol;
}

- (void)setCurrencyFullName:(NSString *)currencyFullName
{
    _currencyFullName = currencyFullName;
    self.currencyNameLabel.text = currencyFullName;
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MSCurrencyInfoCollectionView"
                                                            owner:self
                                                          options:nil][0];
        [self.contentView addSubview:contentView];
        [self setEnabled:YES];
        [self _updateCellsColors];
    }
    return self;
}

#pragma mark - UICollectionViewCell

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    self.activityView.hidden = enabled;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self _updateCellsColors];
}

#pragma mark - MSCurrencyInfoCollectionViewCell ()

- (void)_updateCellsColors
{
    MSStyleSheet *styleSheet = [MSStyleSheet sharedInstance];
    
    if (self.selected) {
        self.backgroundView.backgroundColor = styleSheet.collectionViewCellsSelectedBgColor;
        self.currencySymbolLabel.textColor = styleSheet.lightTextColor;
        self.currencyNameLabel.textColor = styleSheet.lightTextColor;
    }
    else {
        self.backgroundView.backgroundColor = styleSheet.collectionViewCellsUnselectedBgColor;
        self.currencySymbolLabel.textColor = styleSheet.darkTextColor;
        self.currencyNameLabel.textColor = styleSheet.darkTextColor;
    }
}


@end
