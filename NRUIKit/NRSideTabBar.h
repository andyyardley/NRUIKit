//
//  NRSideTabBar.h
//  tubealerts
//
//  Created by Andy Yardley on 01/04/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NRSideTabBar : UIView
{
    BOOL _open;
    BOOL _animating;
    NSInteger _yHeight;
    NSInteger _width;
}

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIView *backgroundViewContainer;
@property (strong, nonatomic) UIView *tabContainer;

@end
