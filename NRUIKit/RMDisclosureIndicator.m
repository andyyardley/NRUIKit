//
//  RMDisclosureIndicator.m
//  ReviewMe
//
//  Created by Andy on 06/07/2011.
//  Copyright 2011 Venalicium Ltd. All rights reserved.
//

#import "RMDisclosureIndicator.h"
#define RIGHT_MARGIN 5
#define CONTROL_IS_HIGHLIGHTED YES

@implementation RMDisclosureIndicator

- (void)drawRect:(CGRect)rect
{
    
    const CGFloat R = 4.5/2;
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    
    if (_direction == NRDisclosureIndicatorRight) {
        // (x,y) is the tip of the arrow
        CGFloat x = CGRectGetMidX(self.bounds);
        CGFloat y = CGRectGetMidY(self.bounds);
        CGContextMoveToPoint(ctxt, x-R, y-(R*2));
        CGContextAddLineToPoint(ctxt, x+R, y);
        CGContextAddLineToPoint(ctxt, x-R, y+(R*2));
    } else {
        // (x,y) is the tip of the arrow
        CGFloat x = CGRectGetMidX(self.bounds);
        CGFloat y = CGRectGetMidY(self.bounds);
        CGContextMoveToPoint(ctxt, x+R, y-(R*2));
        CGContextAddLineToPoint(ctxt, x-R, y);
        CGContextAddLineToPoint(ctxt, x+R, y+(R*2));      
    }
    
    CGContextSetLineCap(ctxt, kCGLineCapSquare);
    CGContextSetLineJoin(ctxt, kCGLineJoinMiter);
    CGContextSetLineWidth(ctxt, 3);
    // If the cell is highlighted (blue background) draw in white; otherwise gray
    //_normalColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    if (CONTROL_IS_HIGHLIGHTED) {
        //CGFloat red = 0.0f, green = 0.0f, blue = 1.0f, alpha = 1.0f;
        //[_normalColor getRed:&red green:&green blue:&blue alpha:&alpha];
//        NSLog(@"%f %f %f %f", red, green, blue, alpha);
        CGContextSetStrokeColorWithColor(ctxt, _normalColor.CGColor);
        //CGContextSetRGBStrokeColor(ctxt, red, green, blue, 1);
    } else {
        CGContextSetRGBStrokeColor(ctxt, 0.5, 0.5, 0.5, 1);
    }
    CGContextStrokePath(ctxt);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _normalColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        _direction = NRDisclosureIndicatorRight;
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _direction = NRDisclosureIndicatorRight;
        _normalColor = color;
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor*)color direction:(NRDisclosureIndicatorDirection)direction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _normalColor = color;
        _direction = direction;
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


@end
