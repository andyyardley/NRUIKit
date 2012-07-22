//
//  NRAlertView.h
//  tubealerts
//
//  Created by Andy Yardley on 01/05/2012.
//  Copyright (c) 2012 Venalicium Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NRAlertView : UIView

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) UIButton *cancel;


- (void)show;
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;


@end
