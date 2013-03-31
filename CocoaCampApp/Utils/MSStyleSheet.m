//
//  MSStyleSheet.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSStyleSheet.h"

@interface MSStyleSheet ()
@property (nonatomic, readwrite, strong) UIColor *mainBackgroundColor;
@property (nonatomic, readwrite, strong) UIColor *separatorColor;
@property (nonatomic, readwrite, strong) UIColor *defaultTextColor;
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
        self.defaultTextColor = [UIColor colorWithWhite:51.f/255.f alpha:1.0];
        
        [self appleAppearanceProxies];
    }
    return self;
}

- (void)appleAppearanceProxies
{
    // Navigation Bar
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navBarBg"] resizableImageWithCapInsets:UIEdgeInsetsZero]
                                       forBarMetrics:UIBarMetricsDefault];
    
    UIImage *backImage = [[UIImage imageNamed:@"backButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    // TODO: rest of buttons
    
    // Table view
    [[UITableView appearance] setSeparatorColor:self.separatorColor];
    
    // Text field
    [[UITextField appearance] setBackgroundColor:[UIColor colorWithWhite:235./255. alpha:1.0]];
}


#pragma mark - MSStyleSheet

@end
