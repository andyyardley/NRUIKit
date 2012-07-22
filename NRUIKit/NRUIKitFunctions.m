//
//  NRUIKitFunctions.m
//  NRUIKit
//
//  Created by Andy Yardley on 22/07/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import "NRUIKitFunctions.h"

CGRect CGRectMove(CGRect rect, CGFloat dx, CGFloat dy)
{
    rect.origin.x = dx;
    rect.origin.y = dy;
    return rect;     
}

CGRect CGRectResize(CGRect rect, CGFloat width, CGFloat height)
{
    rect.size.width = width;
    rect.size.height = height;
    return rect;     
}