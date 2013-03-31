//
//  MSConvertedCurrencyTableViewCell.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSConvertedCurrencyTableViewCell.h"

@interface MSConvertedCurrencyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation MSConvertedCurrencyTableViewCell

#pragma mark - Getters/Setters

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
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MSConvertedCurrencyView"
                                                            owner:self
                                                          options:nil][0];
        [self.contentView addSubview:contentView];

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

@end
