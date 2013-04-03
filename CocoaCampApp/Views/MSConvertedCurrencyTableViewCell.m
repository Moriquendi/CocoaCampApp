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

- (void)setCurrencySymbolBgColor:(UIColor *)currencySymbolBgColor
{
    _currencySymbolBgColor= currencySymbolBgColor;
    self.currencyNameLabel.textColor = currencySymbolBgColor;
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
        [self.contentView addSubview:contentView];

        // Accessory
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        // Appearance
        self.amountLabel.textColor = [[MSStyleSheet sharedInstance] emphasizedTextColor];
    }
    return self;
}

@end
