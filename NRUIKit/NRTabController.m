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

#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define isChild ([_viewControllerStack count]>1)
#define theView ((UIView*)(isChild ? _activeViewContainer : _mainView))

@interface NRTabController ()

@end

@implementation NRTabController

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
        
        // Create and add Main View
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {   
            _mainView = [[UIView alloc] initWithFrame:CGRectMake(_tabBarWidth, 0, self.view.frame.size.width, self.view.frame.size.height)];
        } else {
            _mainView = [[UIView alloc] initWithFrame:CGRectMake(_tabBarWidth, 0, self.view.frame.size.width-_tabBarWidth, self.view.frame.size.height)];    
        }
        _mainView.autoresizesSubviews = YES;
        _mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;     
        [self.view addSubview:_mainView];

        // Create and add container view
        _containerView = [[UIView alloc] initWithFrame:_mainView.bounds];
        _containerView.autoresizesSubviews = YES;
        _containerView.clipsToBounds = YES;
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _containerView.backgroundColor = [UIColor clearColor];
        [_mainView addSubview:_containerView];
        
        // Create and add tab bar
        _tabBarView = [[NRSideTabBar alloc] initWithFrame:CGRectMake(0, 0, _tabBarWidth, self.view.frame.size.height)];
        [self.view insertSubview:_tabBarView belowSubview:_mainView];
        _tabBarView.backgroundColor = self.tabBackgroundColor;
        _tabBarView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.tabBackgroundView.frame = _tabBarView.bounds;
                
        _tabs = [NSMutableArray array];
        _viewControllerStack = [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewController) name:@"popViewController" object:nil];
        
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
    [_tabBarView setNeedsLayout];
    
    for (UIView *view in _containerView.subviews) {
        [[view.subviews objectAtIndex:0] setNeedsDisplay];
    }
}

- (void)panDetected:(UIGestureRecognizer *)sender
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [_viewControllerStack count] == 1) return; 
    
    if (_animating == YES) return;
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _startFrame = theView.frame;
        _animating = NO;
        _lastPanPoint = translatedPoint;
        
        if (!isChild) { 
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTabsVisible object:nil];
        }
        
    }
    
    //Set new frame position
    CGRect frame = _startFrame;
    
    int leftMargin = 0;
    int rightMargin = isChild ? self.view.bounds.size.width : _tabBarWidth-10;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && !isChild) {
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
        [self _moveViews:(frame.origin.x/frame.size.width)];
        
    }
    
    _lastPanPoint = translatedPoint;
    
}

- (void)_moveViews:(CGFloat)percent
{
    
    if (percent>0.0f && _activeViewContainer.layer.shouldRasterize == NO) {
        _activeViewContainer.layer.shouldRasterize = YES;
        _activeViewContainer.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    
    if (percent == 0.0f) _activeViewContainer.layer.shouldRasterize = NO;
    
    if (isChild) {

        NSArray *views = _containerView.subviews;
        
        for (int i=0; i<[views count]; i++) {

            UIView *view = [views objectAtIndex:i];
            
            view.layer.shouldRasterize = YES;
            view.layer.rasterizationScale = [UIScreen mainScreen].scale;
            
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
        
        CGRect frame = theView.frame;
        frame.origin.x = frame.size.width*percent;
        theView.frame = frame;

    }
    
}

- (int)_getDistance
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return _mainView.frame.size.width;
    }
    return isChild ? _mainView.frame.size.width : _tabBarWidth;
}

- (void)popViewController
{
    [self _closeView];
}

- (void)_closeView
{

    _animating = YES;
    
    int distance = [self _getDistance];
    
    _activeViewContainer.layer.shouldRasterize = YES;
    _activeViewContainer.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || [_viewControllerStack count]>1) { 
        
        [UIView animateWithDuration:0.25 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
            
            if ([_viewControllerStack count]>1) { 
            
                NSArray *views = _containerView.subviews;
                
                for (int i=1; i<[views count]-1; i++) {
                    UIView *view = [_containerView.subviews objectAtIndex:i];
                    view.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
                }
                
            } else {
                theView.userInteractionEnabled = NO;
            }
                
            UIView *view = theView;
            
            view.frame = CGRectMake(([_viewControllerStack count]>1)?_containerView.frame.size.width:_tabBarWidth, 0, _containerView.frame.size.width, _containerView.frame.size.height);

        } completion: ^(BOOL finished) {
            _animating = NO;
            
            //After close animation has finished remove view if is child
            if (isChild) {
                [theView removeFromSuperview];
                [_activeTab.controllers removeLastObject];
                [_viewControllerStack removeLastObject];
                _activeViewContainer = [_containerView.subviews lastObject];
                _activeViewContainer.layer.shouldRasterize = NO;
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
    
    [UIView animateWithDuration:0.25 delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
        
        if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [[_viewControllerStack lastObject] viewWillAppear:YES];
        
        if ([_viewControllerStack count]>1) {
            theView.frame = CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height);  
            
            for (int i=0; i<[_containerView.subviews count]; i++) {
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
        if (!isChild) {
            theView.userInteractionEnabled = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTabsHidden object:nil];
        }
    }];
    
}

- (void)popContainerViewController
{
    
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
    
    view.autoresizesSubviews = YES;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    if ([_containerView.subviews count]>0) {
        view.frame = CGRectMove(_containerView.bounds, _containerView.bounds.size.width, 0);
    }

    if (_titleBarHidden == NO) {
    
        // Create title and add to view
        NRSideTitle *title = [[NRSideTitle alloc] initWithFrame:CGRectMake(0, 0, 30, _containerView.bounds.size.height)];
        title.titleLabel.text = [controller valueForKey:@"_title"];
        
        title.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [view addSubview:title];
        
        controller.sideTitle = title;
        
        // Create controller container and add to view
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(30, 0, _containerView.bounds.size.width-30, _containerView.bounds.size.height)];
        [view addSubview:container];
        container.backgroundColor = [UIColor clearColor];
        container.autoresizesSubviews = YES;
        container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        controller.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //controller.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        controller.view.frame = container.bounds;
        
        // Add controller to container
        [container addSubview:controller.view];
        
    } else {
        
        controller.view.frame = view.bounds;
        [view addSubview:controller.view];
        
    }
    
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
    
    //Add Controller To View
    UIView *view = [self _getViewContainerForController:controller];
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [controller viewWillAppear:YES];
    
    [_containerView addSubview:view];
    
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
        
        controller.view.frame = _mainView.bounds;
        
        UIView *view = [self _getViewContainerForController:controller];
        
        [_containerView addSubview:view];
        
        [_viewControllerStack addObject:controller];
        
        if (SYSTEM_VERSION_LESS_THAN(@"5.0")) [controller viewDidAppear:YES];

    }
    
    tab.hasBeenShown = YES;
    
    _activeViewContainer = [_containerView.subviews lastObject];
    
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
    
    controller.view.frame = _mainView.bounds;
    controller.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [tab.controllers addObject:controller];
    
    [_tabs addObject:tab];
    
    if ([_tabs count] == 1) [self tabClick:tab];
    
    [_tabBarView.tabContainer addSubview:tab];
    [_tabBarView.tabContainer sendSubviewToBack:tab];
    
    _tabBarView.tabContainer.frame = CGRectResize(_tabBarView.tabContainer.frame, _tabBarView.tabContainer.frame.size.width, ([_tabs count]+1)*(tab.frame.size.height+1));
    
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
