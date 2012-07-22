//
//  NRTabController.m
//  tubealerts
//
//  Created by Andy Yardley on 01/04/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import "NRTabController.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@interface NRTabController ()

@end

@implementation NRTabController

//@synthesize activeNavigationController = _activeNavigationController;
//@synthesize dragBar = _dragBar;
//@synthesize tabs = _tabs;
//
//@synthesize containerViewStack = _containerViewStack;
//
////@synthesize containerView = _containerView;
//@synthesize activeContainerView = _activeContainerView;
//@synthesize activeContainerController = _activeViewControllerContainer;
//
//@synthesize sideTitle = _sideTitle;

@synthesize tabBackgroundView = _tabBackgroundView;

@synthesize tabBackgroundColor = _tabBackgroundColor;
@synthesize tabColor = _tabColor;
@synthesize tabFontColor = _tabFontColor;
@synthesize tabSelectedColor = _tabSelectedColor;
@synthesize tabSeparatorColor = _tabSeparatorColor;
@synthesize tabShadow = _tabShadow;

//@synthesize activeTab = _activeTab;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //Setup Defaults
        _tabBackgroundColor = [UIColor whiteColor];
        _tabColor           = [UIColor whiteColor];
        _tabSelectedColor   = [UIColor redColor];
        _tabSeparatorColor  = [UIColor blackColor];
        _tabFontColor       = [UIColor whiteColor];
        _tabShadow          = YES;
        _titleBarHidden     = NO;
        _tabBarWidth        = 250;
        
        self.view.backgroundColor = _tabBackgroundColor;
        
        // Create View Controller Stack
        _viewControllerStack = [[NSMutableArray alloc] init];
        
        // Create Main View
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {   
            _mainView = [[UIView alloc] initWithFrame:CGRectMake(_tabBarWidth, 0, self.view.frame.size.width, self.view.frame.size.height)];
        } else {
            _mainView = [[UIView alloc] initWithFrame:CGRectMake(_tabBarWidth, 0, self.view.frame.size.width-_tabBarWidth, self.view.frame.size.height)];    
        }
        _mainView.autoresizesSubviews = YES;
        _mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _mainView.backgroundColor = [UIColor clearColor];
        
        // Add         
        [self.view addSubview:_mainView];

        _containerView = [[UIView alloc] initWithFrame:_mainView.bounds];
        _containerView.autoresizesSubviews = YES;
        _containerView.clipsToBounds = YES;
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _containerView.backgroundColor = [UIColor clearColor];
        [_mainView addSubview:_containerView];
        
        _tabBarView = [[NRSideTabBar alloc] initWithFrame:CGRectMake(0, 0, _tabBarWidth, self.view.frame.size.height)];
        [self.view insertSubview:_tabBarView belowSubview:_mainView];
        
        _tabBarView.backgroundColor = self.tabBackgroundColor;
        
//        _tabBarView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
//        _tabBarView.layer.shouldRasterize = YES;
        _tabBarView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.tabBackgroundView.frame = _tabBarView.bounds;
        //[_tabBarView addSubview:self.tabBackgroundView];
        
//        self.activeNavigationController = [[UINavigationController alloc] init];
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {   
//            self.activeNavigationController.view.frame = CGRectMake(30, 0, self.view.frame.size.width-30, self.view.frame.size.height);
//        } else {
//            self.activeNavigationController.view.frame = CGRectMake(30, 0, self.view.frame.size.width-_tabBarWidth-30, self.view.frame.size.height);
//        }
//        //[_mainView addSubview:self.activeNavigationController.view];
//        
//        self.activeContainerView = _mainView;
//        
        
//        _mainView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        
        [_mainView.layer setShadowColor:[UIColor blackColor].CGColor];
        [_mainView.layer setShadowOffset:CGSizeMake(0, 0)];
        [_mainView.layer setShadowRadius:15];
        _mainView.layer.shadowOpacity = 1.0f;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:_mainView.bounds];
        _mainView.layer.shadowPath = path.CGPath;
        
        //NSLog(@"SIZE %f %f %f %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        
        //DRAG BAR
//       FGDFGDFGFDGFDGDFGDFG **** 
//        self.sideTitle = [[NRSideTitle alloc] initWithFrame:CGRectMake(0, 0, 30, _mainView.bounds.size.height)];
//        [_mainView insertSubview:self.sideTitle belowSubview:_subControllerContainer];
//        
//        self.sideTitle.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        //self.sideTitle.hidden = YES;
        /*
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RightArrow"]];
        arrowImageView.frame = CGRectMake(2, ((dragBarShow.bounds.size.height/2)-3), 6, 6);
        [dragBarShow addSubview:arrowImageView];
        */
        
        
        //self.activeNavigationController.view.layer.shouldRasterize = YES;
        //self.activeNavigationController.view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        
        //self.activeNavigationController.view.clipsToBounds = YES;
        
        //_tabBarView.navigationController = self.activeNavigationController;
        
        //[self.view addSubview:_mainView];
        
        [UIView animateWithDuration:0.2 delay: 1.0 options: UIViewAnimationCurveEaseInOut animations: ^ {
            //_mainView.frame = CGRectMake(-(-10), 0, _mainView.frame.size.width, self.view.frame.size.height);
            //if (self.delegate.history.count>0) [self.toolbar.backButton setAlpha:0.0f];
            //_open = YES;
            _animating = NO;
        } completion: ^(BOOL finished) {
                        
        }];
        
        _tabs = [NSMutableArray array];
        _viewControllerStack = [NSMutableArray array];
        
//        NSLog(@"CONT SIZE: %@", NSStringFromCGRect(_containerView.frame));
        
    }
    return self;
}

- (void)setTabBackgroundColor:(UIColor *)tabBackgroundColor
{
    self.view.backgroundColor = tabBackgroundColor;
    _tabBackgroundColor = tabBackgroundColor;
    _tabBarView.backgroundColor = tabBackgroundColor;
}

- (void)setTabBackgroundView:(UIView *)tabBackgroundView
{
    tabBackgroundView.frame = _tabBarView.bounds;
    [_tabBarView.backgroundViewContainer addSubview:tabBackgroundView];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    NSLog(@"ROTATEtrtrtr111");
    [_tabBarView setNeedsLayout];
//    [self.sideTitle setNeedsDisplay];
//    [self.activeContainerController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
////    self.activeContainerController.view.frame = CGRectMake(0, 0, 480, 320);
////    self.activeContainerController.view.backgroundColor = [UIColor blueColor];
//    [self.activeNavigationController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
////    self.activeNavigationController.view.frame = CGRectMake(0, 0, 480, 320);
////    self.activeNavigationController.view.backgroundColor = [UIColor blueColor];
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//            //_containerView
//        } else {
//            
//        }
//    } else {
//        
//    }
    
    //NSLog(@"CONT SIZE: %@", NSStringFromCGRect(_containerView.frame));
    
}

- (void)panDetected:(UIGestureRecognizer *)sender
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [_viewControllerStack count] == 1) return; 
    
    if (_animating == YES) return;
    
    UIView *theView;
    BOOL isChild = ([_viewControllerStack count]>1);
    
//    if (isChild == NO) {
        theView = _mainView;
//    } else {
//        theView = _activeViewControllerContainer;
//    }
    
//    _mainView.layer.shouldRasterize = YES;
//    self.activeContainerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
//    self.activeContainerView.layer.shouldRasterize = YES;
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _startFrame = theView.frame;
        _animating = NO;
        _lastPanPoint = translatedPoint;
        
        if (![self _isChild]) { 
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTabsVisible object:nil];
        }
        
    }
    
    //Set new frame position
    CGRect frame = _startFrame;
    
    int leftMargin = 0;
    int rightMargin = [self _isChild] ? self.view.bounds.size.width : _tabBarWidth-10;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        leftMargin = _tabBarWidth;
    }
    
    if (_titleBarHidden == YES) leftMargin = 0;
    
    frame.origin.x += translatedPoint.x;
    
    if (frame.origin.x < leftMargin) frame.origin.x = leftMargin;
    if (frame.origin.x > rightMargin) frame.origin.x = rightMargin;

    // Touch and swipe logic
    if (_lastPanPoint.x < (translatedPoint.x-20)) {
        
        //Check for right swipe

        [self _closeView];
        
    } else if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded && frame.origin.x < rightMargin) {
        
        //User Ended Holding Screen
        
        _startFrame = CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height);
        [self _showView]; 
        
    } else {
        
        // User is holding on screen
        //theView.frame = frame;
//        _mainView.layer.shouldRasterize = YES;
        
        [self _moveViews:(frame.origin.x/frame.size.width)];
        
    }
    
    _lastPanPoint = translatedPoint;
    
}

- (void)_moveViews:(CGFloat)percent
{
    
    if (percent>0.0f && _activeViewContainer.layer.shouldRasterize == NO) _activeViewContainer.layer.shouldRasterize = YES;
    
    if (percent == 0.0f) _activeViewContainer.layer.shouldRasterize = NO;
    
    if ([self _isChild]) {
        
//        for (int i=0; i<[_viewControllerStack count]; i++) {
//            
//            UIViewController *controller = [_viewControllerStack objectAtIndex:i];
//
//            if (i==[_viewControllerStack count]-1) {
//                
//                CGRect frame = controller.view.frame;
//                frame.origin.x = frame.size.width*percent;
//                controller.view.frame = frame;
//
//            } else if (([_viewControllerStack count]-i)/10.0f < percent) {
//                
//                if (percent>[_viewControllerStack count]*0.1f) continue;
//                
//                CGRect frame = controller.view.frame;
//                frame.origin.x = frame.size.width*(percent-(([_viewControllerStack count]-i)/10.0f));
//                controller.view.frame = frame;
//                
//            }
//            
//        }
        
        NSArray *views = _containerView.subviews;
        
        for (int i=0; i<[views count]; i++) {
            
            UIView *view = [views objectAtIndex:i];
            
            if (i==[views count]-1) {
                
                CGRect frame = view.frame;
                frame.origin.x = _containerView.frame.size.width*percent;
                view.frame = frame;
                
            } else if (([views count]-i)/10.0f < percent) {
                
                if (percent>[views count]*0.1f) continue;
                
                CGRect frame = view.frame;
                frame.origin.x = _containerView.frame.size.width*(percent-(([views count]-i)/10.0f));
                view.frame = frame;
                
            }
            
        }
        
    } else {
        
        CGRect frame = [self _theView].frame;
        frame.origin.x = frame.size.width*percent;
        [self _theView].frame = frame;

    }
    
}

- (BOOL)_isChild
{
    return ([_viewControllerStack count]>1);
}

- (int)_getDistance
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return _mainView.frame.size.width;
    }
    return [self _isChild] ? _mainView.frame.size.width : _tabBarWidth;
}

- (UIView*)_theView
{
    NSLog(@"STACK COUNT: %i", [_viewControllerStack count]);
    return [self _isChild] ? _activeViewContainer : _mainView;
}

- (void)_closeView
{

    _animating = YES;
    
    UIView *theView = [self _theView];
    int distance = [self _getDistance];
    
    _activeViewContainer.layer.shouldRasterize = YES;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || [_viewControllerStack count]>1) { 
        
        [UIView animateWithDuration:0.2 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
            
//            theView.frame = CGRectMake(distance, 0, theView.frame.size.width, theView.frame.size.height);
            
            NSArray *views = _containerView.subviews;
            
            for (int i=0; i<[views count]; i++) {
            
//            if ([_viewControllerStack count]>1) {
//                for (int i=0; i<[_viewControllerStack count]-1; i++) { 
                    UIView *view = [_containerView.subviews objectAtIndex:i];
                    view.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
//                }
            }
            
        } completion: ^(BOOL finished) {
            _animating = NO;
            
            //After close animation has finished remove view if is child
            if ([self _isChild]) {
                [theView removeFromSuperview];
                [_activeTab.controllers removeLastObject];
                [_viewControllerStack removeLastObject];
                //_activeViewContainer = [_viewControllerStack lastObject];
                _activeViewContainer = [_containerView.subviews lastObject];
                _activeViewContainer.layer.shouldRasterize = NO;
//                _activeViewControllerContainer.layer.shouldRasterize = NO;
//                [_activeViewControllerContainer viewDidAppear:YES];
            }
            
        }];
        
    }
    
}

- (int)_leftMargin
{
    int leftMargin = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        leftMargin = ([_viewControllerStack count]>1)?30+_tabBarWidth:_tabBarWidth;
    }
    return leftMargin;
}

- (void)_showView
{

    _animating = YES;
    
    UIView *theView = [self _theView];
    
//    NSLog(@"VIEW SIZE: %@", NSStringFromCGRect(theView.frame));
    
    return;
    
    [UIView animateWithDuration:0.2 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
        
        if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [[_viewControllerStack lastObject] viewWillAppear:YES];
        
        if ([_viewControllerStack count]>1) {
            theView.frame = CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height);  
            
            for (int i=0; i<[_containerView.subviews count]; i++) {
//            for (int i=0; i<[_viewControllerStack count]-1; i++) { 
                UIView *view = [_containerView.subviews objectAtIndex:i];
                view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            }
        } else {
            theView.frame = CGRectMake([self _leftMargin], 0, theView.frame.size.width, theView.frame.size.height);    
        }
        
        if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [[_viewControllerStack lastObject] viewDidAppear:YES];
        

    } completion: ^(BOOL finished) {
        _animating = NO;
        _activeViewContainer.layer.shouldRasterize = NO;
        if (![self _isChild]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTabsHidden object:nil];
        }
    }];
    
}

- (void)popContainerViewController
{
    
//    int distance = self.view.frame.size.width;
//    
//    _animating = YES;
//    
//    _startFrame = CGRectMake(0, 0, self.activeContainerView.frame.size.width, self.activeContainerView.frame.size.height);
//    
//    [UIView animateWithDuration:0.3f delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
//        
//        _mainView.layer.shouldRasterize = YES;
//        
//        self.activeContainerView.frame = CGRectMake(distance, 0, self.activeContainerView.frame.size.width, self.activeContainerView.frame.size.height);
//        //if (self.delegate.history.count>0) [self.toolbar.backButton setAlpha:1.0f];
//        
//        if ([_viewControllerStack count]>1) {
//            ((UIView*)[_viewControllerStack objectAtIndex:([_viewControllerStack count]-2)]).alpha = 1;
//            ((UIView*)[_viewControllerStack objectAtIndex:([_viewControllerStack count]-1)]).alpha = 0.4f;
//        } else _tabBarView.alpha = 1;
//        
//        _tabBarOpen = NO;
//        
//        //_animating = NO;
//    } completion: ^(BOOL finished) {
//        
//        //_mainView.layer.shouldRasterize = NO;
//        
//        if ([_viewControllerStack count]>1){
//            [self.activeContainerView removeFromSuperview];   
//            [_viewControllerStack removeLastObject];
//            self.activeContainerView = [_viewControllerStack objectAtIndex:([_viewControllerStack count]-1)];
//            
//            [self.activeNavigationController viewWillAppear:YES];
//            [self.activeNavigationController viewDidAppear:YES];
//            
//            if (self.activeContainerController) {
//                [self.activeContainerController viewDidDisappear:YES];
//                self.activeContainerController = nil;
//            }
//        }
//        
//        
//    }];    
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    // Setup gesture recogniser
    self.view.multipleTouchEnabled = YES;
    self.view.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panRecognizer = 
    [[UIPanGestureRecognizer alloc]
     initWithTarget:self 
     action:@selector(panDetected:)];
    [self.view addGestureRecognizer:panRecognizer];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)setTitleBarHidden:(BOOL)hidden
{
    
    _titleBarHidden = hidden;
    
//    if (_titleBarHidden == YES) {
//        self.sideTitle.hidden = YES;
//        CGRect frame = self.activeNavigationController.view.frame;
//        frame.size.width += 30;
//        frame.origin.x -= 30;
//        self.activeNavigationController.view.frame = frame;
//    }
    
}

/**
 *
 * Add a controller to a container view and return the view
 * This is used the 
 *
 **/
- (UIView*)_getViewContainerForController:(UIViewController *)controller
{
    
    UIView *view = [[UIView alloc] initWithFrame:_containerView.bounds];
    
    if ([_containerView.subviews count]>0) {
        //view.frame = CGRectMove(_containerView.bounds, _containerView.bounds.size.width, 0);
    }

    // Create title and add to view
    NRSideTitle *title = [[NRSideTitle alloc] initWithFrame:CGRectMake(0, 0, 30, _containerView.bounds.size.height)];
    title.titleLabel.text = [controller valueForKey:@"_title"];
    [view addSubview:title];
    
    controller.sideTitle = title;
    
    // Create controller container and add to view
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(30, 0, _containerView.bounds.size.width-30, _containerView.bounds.size.height)];
    [view addSubview:container];
    container.backgroundColor = [UIColor yellowColor];
    container.autoresizesSubviews = YES;
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    controller.view.frame = container.bounds;
    
    // Add controller to container
    if ([_viewControllerStack count] <=1) [container addSubview:controller.view];
    
    //Add shadow to view
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOffset:CGSizeMake(0, 0)];
    [view.layer setShadowRadius:15];
    view.layer.shadowOpacity = 1.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.shadowPath = path.CGPath;
    
    return view;
    
}

- (void)pushViewController:(UIViewController *)controller
{

    _activeViewContainer.layer.shouldRasterize = YES;
    controller.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    //Add Controller To Active Tab
    [_activeTab.controllers addObject:controller];

    //Add Controller To View Stack
    [_viewControllerStack addObject:controller];
//    controller.view.frame = CGRectMake(_mainView.bounds.size.width, _mainView.bounds.origin.y, _mainView.bounds.size.width, _mainView.bounds.size.height);
    NSLog(@"%@", NSStringFromCGRect(_mainView.bounds));
    
    //Add Drop Shadow
//    [controller.view.layer setShadowColor:[UIColor blackColor].CGColor];
//    [controller.view.layer setShadowOffset:CGSizeMake(0, 0)];
//    [controller.view.layer setShadowRadius:15];
//    controller.view.layer.shadowOpacity = 1.0f;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:controller.view.bounds];
//    controller.view.layer.shadowPath = path.CGPath;
//    
//    controller.view.layer.shouldRasterize = NO;
//    controller.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    //Add Controller To View
    
    UIView *view = [self _getViewContainerForController:controller];
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [controller viewWillAppear:YES];
    
    [_containerView addSubview:view];
    
//    if (_titleBarHidden) {
//        [_containerView addSubview:controller.view];
//    } else {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_mainView.bounds.size.width+30, _mainView.bounds.origin.y, _mainView.bounds.size.width-30, _mainView.bounds.size.height)];
//        [view addSubview:controller.view];
//        [_containerView addSubview:view];
//    }
    
//    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [controller viewDidAppear:YES];
    
    //Set Controller Active
    _activeViewContainer = view;
    
    [self _showView];
    
}

- (void)hideVisibleControllers
{
    
    //Remove Controllers From View
    for (UIViewController *controller in _viewControllerStack) {
        [controller viewWillDisappear:YES];
        [controller.view removeFromSuperview];
        [controller viewDidDisappear:YES];
    }
    
    //Clear View Stack
    [_viewControllerStack removeAllObjects];
    
}

- (void)showControllers:(NRTab*)tab
{

    NSArray *controllers = tab.controllers;

    // Remove all current views
    for (UIView *view in _containerView.subviews) {
        [view removeFromSuperview];
    }
    
    //Add Controllers To View And View Stack
    for (UIViewController *controller in controllers) {
        
        if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [controller viewWillAppear:YES];
        
        
//        if (controller == [controllers objectAtIndex:0] && _sideTitle.hidden == NO) {
//            NSLog(@"SIDE TITLE");
//            controller.view.frame = CGRectMake(30, 0, _mainView.bounds.size.width-30, _mainView.bounds.size.height);
//        } else {
            controller.view.frame = _mainView.bounds;
//        }
        
//        UIView *view = [[UIView alloc] initWithFrame:_containerView.bounds];
//        NRSideTitle *title = [[NRSideTitle alloc] initWithFrame:CGRectMake(0, 0, 30, _containerView.bounds.size.height)];
//        [view addSubview:title];
//        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(30, 0, _containerView.bounds.size.width-30, _containerView.bounds.size.height)];
//        [view addSubview:container];
//        container.autoresizesSubviews = YES;
//        controller.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
//        controller.view.frame = container.bounds;
//        [container addSubview:controller.view];
        
        UIView *view = [self _getViewContainerForController:controller];
        
        [_containerView addSubview:view];
        
        [_viewControllerStack addObject:controller];
        if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [controller viewWillAppear:YES];
//        NSLog(@"WTF");
    }
    
    tab.hasBeenShown = YES;
    
    _activeViewContainer = [_containerView.subviews lastObject];
    
    NSLog(@"TEST: %@", _activeViewContainer);
    NSLog(@"TEST: %@", _activeViewContainer);
    
}

- (IBAction)tabClick:(id)sender
{

    //Remove currently open tab controllers
    if (_activeTab != nil) {
        [self hideVisibleControllers];
        _activeTab.selected = NO;
    }
    
    //Setup new tab
    _activeTab = sender;
    _activeTab.selected = YES;
    _activeTab.hasBeenShown = NO;
    
    //Add controllers for new tab
    [self showControllers:_activeTab];
    
    [self _showView];

}

- (void)newContainerViewController:(UIViewController*)controller
{
    
    [self pushViewController:controller];
    
}

- (void)addTab:(NSString*)image title:(NSString*)title controller:(UIViewController*)controller
{
    
    NRTab *tab = [[NRTab alloc] initWithFrame: CGRectMake(0, (([_tabs count]+1)*45), (_tabBarWidth), 44) title:title controller:controller];

    tab.tabController = self;
    
    tab.backgroundColor = self.tabColor;
    
    tab.tabColor = self.tabColor;
    tab.tabSelectedColor = self.tabSelectedColor;
    tab.tabShadow = self.tabShadow;
    
    //[_tabs addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:image, title, controller, tab, [NSMutableArray array], nil] forKeys:[NSArray arrayWithObjects:@"image", @"title", @"controller", @"control", @"controllers", nil]]];
    
    controller.view.frame = _mainView.bounds;
    controller.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [tab.controllers addObject:controller];
    
    [_tabs addObject:tab];
    
    if ([_tabs count] == 1) [self tabClick:tab];
    
    [_tabBarView.tabContainer addSubview:tab];
    [_tabBarView.tabContainer sendSubviewToBack:tab];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
}

@end

@implementation NRTabNavigationController

@end

static char NAVIGATION_CONTROLLER_IDENTIFER;
static char SIDE_TITLE_IDENTIFER;

@implementation UIViewController (NRTabNavigationController)

- (void)setNavigationController:(NRTabNavigationController*)navigationController
{
    objc_setAssociatedObject(self, &NAVIGATION_CONTROLLER_IDENTIFER, navigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NRTabNavigationController*)navigationController
{
    return objc_getAssociatedObject(self, &NAVIGATION_CONTROLLER_IDENTIFER);
}

- (void)setSideTitle:(NRSideTitle *)sideTitle
{
    objc_setAssociatedObject(self, &SIDE_TITLE_IDENTIFER, sideTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);    
}

- (NRSideTitle*)sideTitle
{
    return objc_getAssociatedObject(self, &SIDE_TITLE_IDENTIFER);
}

@end
