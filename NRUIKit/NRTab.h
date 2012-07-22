//
//  NRTab.h
//  tubealerts
//
//  Created by Andy Yardley on 23/04/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NRTabController;
@class RMDisclosureIndicator;

@interface NRTab : UIControl
{
    UILabel *label;
}

@property (strong, nonatomic) NRTabController *tabController;
@property (strong, nonatomic, readonly) RMDisclosureIndicator *disclosure; 

@property (strong, nonatomic) NSMutableArray *controllers;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title controller:(UIViewController*)controller;

@property (strong, nonatomic) UIColor   *tabColor;
@property (strong, nonatomic) UIColor   *tabFontColor;
@property (strong, nonatomic) UIColor   *tabSelectedColor;
@property (nonatomic) BOOL              tabShadow;
@property (nonatomic) BOOL              hasBeenShown;

@end
