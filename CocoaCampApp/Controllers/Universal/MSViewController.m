//
//  MSViewController.m
//  CocoaCampApp
//
//  Created by Michal Smialko on 02.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSViewController.h"
#import "NSObject+DeviceClasses.h"

@interface MSViewController ()
@property (nonatomic, strong) UIPopoverController *pickerPopover;
@end

@implementation MSViewController

+ (id)alloc
{
    return [self deviceAlloc];
}

#pragma mark - MSViewController

- (void)presentAccessoryViewController:(UIViewController *)controller sender:(id)sender
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        [self.navigationController pushViewController:controller animated:YES];
    }
    else {
        if ([sender isKindOfClass:[UIView class]]) {
            self.pickerPopover = [[UIPopoverController alloc] initWithContentViewController:controller];
            [self.pickerPopover presentPopoverFromRect:((UIView *)sender).frame
                                                inView:[sender superview]
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
        
            [self.pickerPopover setPopoverContentSize:self.pickerPopover.contentViewController.contentSizeForViewInPopover
                                             animated:YES];
        }
    }
}

@end
