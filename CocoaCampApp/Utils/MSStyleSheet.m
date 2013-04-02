//
//  MSStyleSheet.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSStyleSheet.h"

#define BACK_BUTTON_RESIZABLE_INSETS    UIEdgeInsetsMake(0, 15, 0, 5)

@interface MSStyleSheet ()
@property (nonatomic, readwrite, strong) UIColor *mainBackgroundColor;
@property (nonatomic, readwrite, strong) UIColor *separatorColor;
@property (nonatomic, readwrite, strong) UIColor *emphasizedTextColor;
@property (nonatomic, readwrite, strong) UIColor *darkTextColor;
@property (nonatomic, readwrite, strong) UIColor *lightTextColor;
@end

@implementation MSStyleSheet

#pragma mark + MSStyleSheet

+ (instancetype)sharedInstance
{
    static MSStyleSheet *_sharedInstance = nil;
    
    if (!_sharedInstance) {
        _sharedInstance = [[MSStyleSheet alloc] init];
    }
    
    return _sharedInstance;
}

#pragma mark - NSObject

- (id)init
{
    if (self = [super init]) {
        self.mainBackgroundColor = [UIColor colorWithRed:242.f/255.f
                                                   green:241.f/255.f
                                                    blue:237.f/255.f
                                                   alpha:1.0];
        self.separatorColor = [UIColor colorWithWhite:100.f/255.f alpha:0.6];
        self.darkTextColor = [UIColor colorWithWhite:51.f/255.f alpha:1.0];
        self.lightTextColor = [UIColor colorWithWhite:230.f/255.f alpha:1.0];

        self.emphasizedTextColor = [UIColor colorWithRed:241.f/255.f
                                                   green:71.f/255.f
                                                    blue:66.f/255.f
                                                   alpha:1.0];

        [self _applyAppearanceProxies];
    }
    return self;
}

#pragma mark - MSStyleSheet

- (UIColor *)randomColorAtIndex:(NSUInteger)index
{
    CGFloat jump = 100;
    CGFloat hue = 10.f + (int)(jump * index) % 360;
    static CGFloat saturation = 73.f;
    static CGFloat brightness = 95.f;
    UIColor *randomColor = [UIColor colorWithHue:hue / 360.f
                                      saturation:saturation / 100.f
                                      brightness:brightness / 100.f
                                           alpha:0.7];
    return randomColor;
}

#pragma mark - MSStyleSheet ()

- (void)_applyAppearanceProxies
{
    // Navigation Bar background
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navBarBg"] resizableImageWithCapInsets:UIEdgeInsetsZero]
                                       forBarMetrics:UIBarMetricsDefault];

    // Navigation Bar Title attributes
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor],
                         UITextAttributeTextShadowColor : [UIColor lightGrayColor]}];

    // Navigation Bar buttons
    UIImage *backImage = [[UIImage imageNamed:@"backButton"] resizableImageWithCapInsets:BACK_BUTTON_RESIZABLE_INSETS];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    // TODO: rest of buttons
    
    // Table view
    [[UITableView appearance] setSeparatorColor:self.separatorColor];
    
    // Text field
    [[UITextField appearance] setBackgroundColor:[UIColor colorWithWhite:235./255. alpha:1.0]];
}

@end
