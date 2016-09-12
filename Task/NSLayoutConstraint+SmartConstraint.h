//
//  NSLayoutConstraint+SmartConstraint.h
//  Task
//
//  Created by Petko Todorov on 9/12/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (SmartConstraint)

+(void) centerViewVerticallyToSuperview : (UIView*) viewToCenter;
+(void) centerViewHorizontallyToSuperview : (UIView*) viewToCenter;
+(void) centerViewVertically: (UIView*) viewToCenter withOtherView: (UIView*) otherView;
+(void) setProportionalHeightToSuperview: (UIView*) subview withMultiplier:(CGFloat) multiplier;
+(void) setProportionalWidthToSuperview: (UIView*) subview withMultiplier:(CGFloat) multiplier;
+(void) setHeightConstraintToView: (UIView*) subview withConstant: (CGFloat) constant;
+(void) setWidthConstraintToView: (UIView*) subview withConstant: (CGFloat) constant;


@end
