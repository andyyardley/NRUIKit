//
//  NRTab.m
//  tubealerts
//
//  Created by Andy Yardley on 23/04/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import "NRTab.h"

#import "RMDisclosureIndicator.h"

#import <QuartzCore/QuartzCore.h>


@implementation NRTab

@synthesize tabController = _tabController;
@synthesize disclosure = _disclosure;

@synthesize controllers = _controllers;

@synthesize tabColor = _tabColor;
@synthesize tabFontColor = _tabFontColor;
@synthesize tabSelectedColor = _tabSelectedColor;
@synthesize tabShadow = _tabShadow;

@synthesize hasBeenShown = _hasBeenShown;

@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title controller:(UIViewController*)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _hasBeenShown = NO;
        
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        
        //self.backgroundColor = [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f];
        
        [self addTarget:self.tabController action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        /*[self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(0, 0)];
        [self.layer setShadowRadius:15];
        self.layer.shadowOpacity = 1.0f;*/
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width-20, 44)];
        label.font = [UIFont boldSystemFontOfSize:14.0f];
        
        label.font = [UIFont fontWithName:@"VAGRounded BT" size:17];
        
        self.tabFontColor = [UIColor blackColor];
        
        label.textColor = self.tabFontColor;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.text = title;//title;
//        label.shadowColor = [UIColor blackColor];
//        label.shadowOffset = CGSizeMake(0.0, 1.0);
        
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(0, 0)];
        [self.layer setShadowRadius:7];
        self.layer.shadowOpacity = 0.0f;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(-20, 0, self.bounds.size.width+40, self.bounds.size.height)];
        self.layer.shadowPath = path.CGPath;
//        self.alpha = 0.4f;
        
        [self addSubview:label];
        
        _disclosure = [[RMDisclosureIndicator alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, 0, 20, 44)];
        [self addSubview:_disclosure];
        _disclosure.hidden = YES;
        
//        UIView *highlight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
//        highlight.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
//        [self addSubview:highlight];
//        
//        UIView *lowlight = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
//        lowlight.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
//        [self addSubview:lowlight];
        
        //[self.dragBar insertSubview:view atIndex:0];
        
        _controllers = [NSMutableArray array];
        
    }
    return self;
}

- (void)setTabShadow:(BOOL)tabShadow
{
    _tabShadow = tabShadow;
    if (tabShadow == YES) {
        
    } else {
        self.layer.shadowOpacity = 0.0f;
    }
}

- (void)setSelected:(BOOL)selected
{
    
    _selected = selected;
    
    if (selected == YES) {
        
        self.backgroundColor = self.tabSelectedColor;
        _disclosure.hidden = NO;
        self.alpha = 1.0f;
        label.textColor = [UIColor whiteColor];
        if (self.tabShadow == YES) self.layer.shadowOpacity = 1.0f;
        
    } else {
        
        self.backgroundColor = self.tabColor; 
        _disclosure.hidden = YES;
        label.textColor = self.tabFontColor;
        if (self.tabShadow == YES) {
            self.alpha = 0.4f;
            self.layer.shadowOpacity = 0.0f;    
        }
        
    }
    
}

- (BOOL)isSelected
{
    return _selected;
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
