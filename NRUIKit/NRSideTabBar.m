//
//  NRSideTabBar.m
//  tubealerts
//
//  Created by Andy Yardley on 01/04/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import "NRSideTabBar.h"

@implementation NRSideTabBar

@synthesize navigationController = _navigationController;
@synthesize backgroundViewContainer = _backgroundViewContainer;
@synthesize tabContainer = _tabContainer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _yHeight = 480-60;
        _width = 150;
        
        self.backgroundColor = [UIColor colorWithRed:0.075f green:0.075f blue:0.075f alpha:1.0f];

        self.backgroundViewContainer = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews = YES;
        [self addSubview:self.backgroundViewContainer];
        
        self.tabContainer = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.tabContainer];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_backgroundViewContainer != nil) {
        
        [_backgroundViewContainer setNeedsLayout];
        _backgroundViewContainer.frame = self.frame;
        for (UIView *view in _backgroundViewContainer.subviews) {
            view.frame = _backgroundViewContainer.bounds;
            [view setNeedsLayout];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
