//
//  NRSideTitle.m
//  tubealerts
//
//  Created by Andy Yardley on 23/04/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import "NRSideTitle.h"

#import <QuartzCore/QuartzCore.h>

static inline UIImage* MTDContextCreateRoundedMask( CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br ) {  
    
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    rect.size.width *= [[UIScreen mainScreen] scale];
    rect.size.height *= [[UIScreen mainScreen] scale];
    
    radius_tl *= [[UIScreen mainScreen] scale];
    radius_tr *= [[UIScreen mainScreen] scale];
    radius_bl *= [[UIScreen mainScreen] scale];
    radius_br *= [[UIScreen mainScreen] scale];
    
    // create a bitmap graphics context the size of the image
    context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast );
    
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);    
    
    if ( context == NULL ) {
        return NULL;
    }
    
    // cerate mask
    
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
    
    CGContextBeginPath( context );
    CGContextSetGrayFillColor( context, 1.0, 0.0 );
    CGContextAddRect( context, rect );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    CGContextSetGrayFillColor( context, 1.0, 1.0 );
    CGContextBeginPath( context );
    CGContextMoveToPoint( context, minx, midy );
    CGContextAddArcToPoint( context, minx, miny, midx, miny, radius_bl );
    CGContextAddArcToPoint( context, maxx, miny, maxx, midy, radius_br );
    CGContextAddArcToPoint( context, maxx, maxy, midx, maxy, radius_tr );
    CGContextAddArcToPoint( context, minx, maxy, minx, midy, radius_tl );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage( context );
    CGContextRelease( context );
    
    // convert the finished resized image to a UIImage 
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    // image is retained by the property setting above, so we can 
    // release the original
    CGImageRelease(bitmapContext);
    
    // return the image
    return theImage;
} 

@implementation NRSideTitle

@synthesize titleLabel = _titleLabel;

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    UIImage *mask = MTDContextCreateRoundedMask( self.bounds, 10.0, 0.0, 10.0, 0.0 );
    // Create a new layer that will work as a mask
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = self.bounds;       
    // Put the mask image as content of the layer
    layerMask.contents = (id)mask.CGImage;       
    // set the mask layer as mask of the view layer
    self.layer.mask = layerMask; 
}

- (void)initialize
{

    self.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    //self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    
    // Create the mask image you need calling the previous function
    UIImage *mask = MTDContextCreateRoundedMask( self.bounds, 10.0, 0.0, 10.0, 0.0 );
    // Create a new layer that will work as a mask
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = self.bounds;       
    // Put the mask image as content of the layer
    layerMask.contents = (id)mask.CGImage;       
    // set the mask layer as mask of the view layer
    self.layer.mask = layerMask;    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-self.bounds.size.height/2+(self.bounds.size.width/2), self.bounds.size.height/2-(self.bounds.size.width), self.bounds.size.height, self.bounds.size.width)];
    self.titleLabel.text = @"TEST";
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:@"VAGRounded BT" size:18];//[UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    //self.titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    [self addSubview:self.titleLabel];
    
    CGAffineTransform xform = CGAffineTransformMakeRotation((M_PI/2.0)*3.0);
    self.titleLabel.transform = xform;
    
    UIView *topBarDragIcon = [[UIView alloc] initWithFrame:CGRectMake(7, 10, 3, 18)];
    topBarDragIcon.backgroundColor = [UIColor whiteColor];
    topBarDragIcon.layer.cornerRadius = 1.5f;
    [self addSubview:topBarDragIcon];

    
    topBarDragIcon = [[UIView alloc] initWithFrame:CGRectMake(13, 10, 3, 18)];
    topBarDragIcon.backgroundColor = [UIColor whiteColor];
    topBarDragIcon.layer.cornerRadius = 1.5f;
    [self addSubview:topBarDragIcon];

    
    topBarDragIcon = [[UIView alloc] initWithFrame:CGRectMake(19, 10, 3, 18)];
    topBarDragIcon.backgroundColor = [UIColor whiteColor];
    topBarDragIcon.layer.cornerRadius = 1.5f;
    [self addSubview:topBarDragIcon];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
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
