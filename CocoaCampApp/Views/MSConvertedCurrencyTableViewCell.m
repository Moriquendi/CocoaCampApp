//
//  MSConvertedCurrencyTableViewCell.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSConvertedCurrencyTableViewCell.h"
#import "MSStyleSheet.h"

@interface MSConvertedCurrencyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencySymbolLabel;

@end

@implementation MSConvertedCurrencyTableViewCell

#pragma mark - Getters/Setters

- (void)setFullCurrencyName:(NSString *)fullCurrencyName
{
    _fullCurrencyName = fullCurrencyName;
    self.currencyNameLabel.text = fullCurrencyName;
}
- (void)setISOCurrencySymbol:(NSString *)ISOCurrencySymbol
{
    _ISOCurrencySymbol = ISOCurrencySymbol;
    self.currencySymbolLabel.text = ISOCurrencySymbol;
}

- (void)setAmount:(NSString *)amount
{
    _amount = amount;
    self.amountLabel.text = amount;
}

#pragma mark - UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Content view
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MSConvertedCurrencyView"
                                                            owner:self
                                                          options:nil][0];
        contentView.frame = self.contentView.bounds;
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:contentView];
        // Accessory
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        // Appearance
        self.amountLabel.textColor = [[MSStyleSheet sharedInstance] emphasizedTextColor];
    }
    return self;
}

@end
