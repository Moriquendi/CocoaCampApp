//
//  MSFlagImageView.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSFlagImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface MSFlagImageView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation MSFlagImageView

- (void)awakeFromNib
{
    // Gradient layer
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.colors = @[(id)[[[UIColor blackColor] colorWithAlphaComponent:0.7] CGColor],
                                  (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
                                  (id)[[[UIColor blackColor] colorWithAlphaComponent:0.0] CGColor]];
    self.gradientLayer.transform = CATransform3DRotate(self.gradientLayer.transform, M_PI_2, 0, 0, 1);
    [self.layer addSublayer:self.gradientLayer];
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect halfOfBoundRect = CGRectMake(0,
                                        0,
                                        self.bounds.size.width/2.,
                                        self.bounds.size.height);
    self.gradientLayer.frame = CGRectOffset(halfOfBoundRect, self.bounds.size.width/2., 0);
}

@end
