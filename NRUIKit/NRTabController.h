//
//  NRTabController.h
//  tubealerts
//
//  Created by Andy Yardley on 01/04/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NRSideTabBar.h"
#import "NRSideTitle.h"
#import "NRTab.h"
#import "NRUIKitFunctions.h"

#define kNotificationTabsVisible @"NotificationTabsVisible"
#define kNotificationTabsHidden  @"NotificationTabsHidden"

#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@class NRSideTabBar;
@class NRSideTitle;
@class NRTab;

@interface NRTabController : UIViewController <UIGestureRecognizerDelegate>
{
    
    BOOL                _tabBarOpen;
    BOOL                _animating;
    NSInteger           _tabBarWidth;
    CGRect              _startFrame;
    CGPoint             _lastPanPoint;
    
    NSMutableArray      *_tabNavigationControllers;
    
    NSMutableArray      *_tabs;
    NSMutableArray      *_viewControllerStack;
    
    NRSideTabBar        *_tabBarView;          // Tab view
    UIView              *_mainView;         // Main view that slides over the tabs
    UIView              *_containerView;    // Container that holds the view inside the main view, used to clip the shadows
    
    NSUInteger          *_selectedTabIndex;
    
    BOOL                _titleBarHidden;
    
    UIView              *_activeViewContainer;
    UIViewController    *_activeViewController;
    
    NRTab               *_activeTab;
    
}

//@property (strong, nonatomic) UINavigationController *activeNavigationController;
//@property (strong, nonatomic) NRSideTabBar *dragBar;
//
//@property (strong, nonatomic, readonly) NSMutableArray *tabs;
//@property (strong, nonatomic, readonly) NRTab *activeTab;
//
//@property (strong, nonatomic) UIView *containerView;
//@property (strong, nonatomic) UIView *activeContainerView;
//@property (strong, nonatomic) UIViewController *activeContainerController;
//
//@property (strong, nonatomic) NSMutableArray *containerViewStack;
//
//@property (strong, nonatomic) NRSideTitle *sideTitle;

@property (strong, nonatomic) UIView  *tabBackgroundView;

@property (strong, nonatomic) UIColor *tabBackgroundColor;
@property (strong, nonatomic) UIColor *tabColor;
@property (strong, nonatomic) UIColor *tabSelectedColor;
@property (strong, nonatomic) UIColor *tabSeparatorColor;
@property (strong, nonatomic) UIColor *tabFontColor;
@property (nonatomic) BOOL tabShadow;

- (void)addTab:(NSString*)image title:(NSString*)title controller:(UIViewController*)controller;
- (void)newContainerViewController:(UIViewController*)controller;
- (void)pushViewController:(UIViewController*)controller;
- (IBAction)tabClick:(UIControl*)sender;
- (void)popContainerViewController;
- (void)setTitleBarHidden:(BOOL)hidden;

@end

@interface NRTabNavigationController : NRTabController

@end

@interface UIViewController (NRNavigationControllerItem)

@property (strong, readonly, nonatomic) NRTabNavigationController *navigationController;
@property (strong, nonatomic)           NRSideTitle               *sideTitle;

@end
