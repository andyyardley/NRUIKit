//
//  NRAlertView.m
//  tubealerts
//
//  Created by Andy Yardley on 01/05/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import "NRAlertView.h"

#import <QuartzCore/QuartzCore.h>

@implementation NRAlertView

@synthesize title = _title;
@synthesize message = _message;
@synthesize cancel = _cancel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{

    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
        self.title = title;
        self.message = message;
        self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        self.layer.shouldRasterize = YES;
        
        [self.cancel setTitle:cancelButtonTitle forState:UIControlStateNormal];
        
        [self.cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.cancel.titleLabel.font = [UIFont fontWithName:@"VAGRounded BT" size:16];
        self.cancel.layer.cornerRadius = 6.0f;
        self.cancel.backgroundColor = [UIColor whiteColor];
        
        [self.cancel addTarget:self action:@selector(highlightButton) forControlEvents:UIControlEventTouchDown];
        [self.cancel addTarget:self action:@selector(highlightButton) forControlEvents:UIControlEventTouchUpOutside];
        [self.cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;    

}

- (void)highlightButton
{
    if (self.cancel.highlighted) {
        self.cancel.backgroundColor = [UIColor grayColor];
    } else {
        self.cancel.backgroundColor = [UIColor whiteColor];
    }
}

- (void)dismiss
{
    self.cancel.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.2f delay: 0.0 options: UIViewAnimationCurveEaseOut animations: ^ {
        self.alpha = 0.0f;
    } completion: ^(BOOL finished) {    
        [self removeFromSuperview];
    }];
}

- (void)show
{
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    int height = 200;
    int width = 260;
    
    UIView *alert = [[UIView alloc] initWithFrame:CGRectMake((window.bounds.size.width/2) - (width/2), (window.bounds.size.height/2) - (height/2)+75, width, height)];
    alert.backgroundColor = [UIColor whiteColor];
    
    alert.layer.borderColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f].CGColor;
    alert.layer.borderWidth = 3.0f;
    alert.layer.cornerRadius = 10.0f;
    alert.alpha = 0.0f;
    
    alert.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
    
    alert.layer.shadowColor = [UIColor blackColor].CGColor;
    alert.layer.shadowOffset = CGSizeMake(0, 0);
    alert.layer.shadowRadius = 15.0f;
    alert.layer.shadowOpacity = 1.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:alert.bounds];
    alert.layer.shadowPath = path.CGPath;
    
    [self addSubview:alert];
    
    //Add Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 3, width-14, 40)];
    titleLabel.text = self.title;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"VAGRounded BT" size:18];
    [alert addSubview:titleLabel];
    
    //Add Message
    UITextView *messageLabel = [[UITextView alloc] initWithFrame:CGRectMake(0, 45, width, 100)];
    messageLabel.editable = NO;
    messageLabel.scrollEnabled = YES;
    messageLabel.text = self.message;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.font = [UIFont fontWithName:@"VAGRounded BT" size:13];
    [alert addSubview:messageLabel];
    
    //Add Cancel Button
    self.cancel.frame = CGRectMake(5, height-44-5, width-10, 44);
    [alert addSubview:self.cancel];
    
    self.frame = window.bounds;
    self.alpha = 0.0f;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.2f delay: 0.0f options: UIViewAnimationCurveEaseOut animations: ^ {
        
        self.alpha = 1.0f;
        
    } completion: ^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:0.5f delay: 0.0f options: UIViewAnimationCurveEaseOut animations: ^ {
        
        alert.alpha = 1.0f;
        
        CGRect frame = alert.frame;
        frame.origin.y -= 75;
        alert.frame = frame;
        
    } completion: ^(BOOL finished) {
    }];
    
}

@end
