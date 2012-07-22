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
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -1, self.bounds.size.width, 44)];
        //toolBar.tintColor = [UIColor blackColor];
        //[self addSubview:toolBar];
        
        self.backgroundColor = [UIColor colorWithRed:0.075f green:0.075f blue:0.075f alpha:1.0f];
        //self.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
        
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
            //view.frame = self.frame;
        }
    }
    
}

/*
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    NSInteger speed = 0.5;
    
    if (_animating == YES) return;

    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    
    //Vertical
    //self.frame = CGRectMake(0, location.y>_yHeight?-10:location.y-_yHeight-10, self.frame.size.width, self.frame.size.height);
    
    //Horizontal
    
    int dragLocation = location.x-self.frame.size.width;
    int xPos = dragLocation;
    
    NSLog(@"WIDTH: %f", self.frame.size.width);
    
    if (xPos<-(self.frame.size.width-15)) xPos = -(self.frame.size.width-15);
    if (xPos>0) xPos = 0;
    
    self.frame = CGRectMake(xPos, 0, self.frame.size.width, self.frame.size.height);
    
    CGRect frame = self.navigationController.view.frame;
    frame.origin.x = xPos + self.frame.size.width;
    self.navigationController.view.frame = frame;
    
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    if (_animating == YES) return;
    
    //Vertical
    
//    if ((_open==YES && location.y>_yHeight-(_yHeight/6)) || (_open==NO && location.y>(_yHeight/6))) {
//        [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
//            self.frame = CGRectMake(0, -10, self.frame.size.width, self.frame.size.height);
//            //if (self.delegate.history.count>0) [self.toolbar.backButton setAlpha:0.0f];
//            _open = YES;
//            _animating = NO;
//        } completion: ^(BOOL finished) {
//        }];
//        return;
//    }
//    
//    if ((_open==YES && location.y<_yHeight-(_yHeight/6)) || (_open==NO && location.y<(_yHeight/6))) {
//        [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
//            self.frame = CGRectMake(0, -_yHeight-10, self.frame.size.width, self.frame.size.height);
//            //if (self.delegate.history.count>0) [self.toolbar.backButton setAlpha:1.0f];
//            _open = NO;
//            _animating = NO;
//        } completion: ^(BOOL finished) {
//        }];
//        return;
//    }
    
    //Horizontal
    if ((_open==YES && location.x>_width-(_width/6)) || (_open==NO && location.x>(_width/6))) {
        [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
            self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            //if (self.delegate.history.count>0) [self.toolbar.backButton setAlpha:0.0f];
            
            
            CGRect frame = self.navigationController.view.frame;
            frame.origin.x = self.frame.size.width;
            self.navigationController.view.frame = frame;
            
            _open = YES;
            _animating = NO;
        } completion: ^(BOOL finished) {
        }];
        return;
    }
    
    if ((_open==YES && location.x<_width-(_width/6)) || (_open==NO && location.x<(_width/6))) {
        [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
            self.frame = CGRectMake(-self.frame.size.width+15, 0, self.frame.size.width, self.frame.size.height);
            //if (self.delegate.history.count>0) [self.toolbar.backButton setAlpha:1.0f];
            
            CGRect frame = self.navigationController.view.frame;
            frame.origin.x = 15;
            self.navigationController.view.frame = frame;
            
            _open = NO;
            _animating = NO;
        } completion: ^(BOOL finished) {
        }];
        return;
    }
    
}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
