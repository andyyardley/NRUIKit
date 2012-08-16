//
//  NRDisclosureIndicator.h
//
//  Created by Andy on 06/07/2011.
//  Copyright 2011 Venalicium Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NRDisclosureIndicatorRight,
    NRDisclosureIndicatorLeft
} NRDisclosureIndicatorDirection;

@interface NRDisclosureIndicator : UIView {
    UIColor *_normalColor;
    NRDisclosureIndicatorDirection _direction;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor*)color;
- (id)initWithFrame:(CGRect)frame color:(UIColor*)color direction:(NRDisclosureIndicatorDirection)direction;

@end
