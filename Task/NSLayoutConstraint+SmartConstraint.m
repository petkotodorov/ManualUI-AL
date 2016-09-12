//
//  NSLayoutConstraint+SmartConstraint.m
//  Task
//
//  Created by Petko Todorov on 9/12/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "NSLayoutConstraint+SmartConstraint.h"

@implementation NSLayoutConstraint (SmartConstraint)

+(void) centerViewVerticallyToSuperview : (UIView*) viewToCenter {
    NSLayoutConstraint *centerVerticallyConstarint = [NSLayoutConstraint constraintWithItem:viewToCenter
                                                                                  attribute:NSLayoutAttributeCenterY
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:viewToCenter.superview
                                                                                  attribute:NSLayoutAttributeCenterY
                                                                                 multiplier:1.0
                                                                                   constant:0];
    [viewToCenter.superview addConstraint:centerVerticallyConstarint];
}

+(void) centerViewHorizontallyToSuperview : (UIView*) viewToCenter {
    NSLayoutConstraint *centerHorizontallyConstarint = [NSLayoutConstraint constraintWithItem:viewToCenter
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:viewToCenter.superview
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                 multiplier:1.0
                                                                                   constant:0];
    [viewToCenter.superview addConstraint:centerHorizontallyConstarint];
}


+(void) setProportionalWidthToSuperview: (UIView*) subview withMultiplier:(CGFloat) multiplier {
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:subview
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:subview.superview
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:multiplier
                                                                        constant:0];
    [subview.superview addConstraint:widthConstraint];
}

+(void) setProportionalHeightToSuperview: (UIView*) subview withMultiplier:(CGFloat) multiplier {
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:subview
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:subview.superview
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:multiplier
                                                                        constant:0];
    [subview.superview addConstraint:heightConstraint];
}


+(void) setHeightConstraintToView: (UIView*) subview withConstant: (CGFloat) constant {
    NSLayoutConstraint *heightConstraints = [NSLayoutConstraint constraintWithItem:subview
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:constant];
    [subview addConstraint:heightConstraints];
    
}

+(void) setWidthConstraintToView: (UIView*) subview withConstant: (CGFloat) constant {
    NSLayoutConstraint *widthConstraints = [NSLayoutConstraint constraintWithItem:subview
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:constant];
    [subview addConstraint:widthConstraints];
    
}

+(void) centerViewVertically: (UIView*) viewToCenter withOtherView: (UIView*) otherView {
    NSLayoutConstraint *centerHorizontallyConstarint = [NSLayoutConstraint constraintWithItem:viewToCenter
                                                                                    attribute:NSLayoutAttributeCenterY
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:otherView
                                                                                    attribute:NSLayoutAttributeCenterY
                                                                                   multiplier:1.0
                                                                                     constant:0];
    [viewToCenter.superview addConstraint:centerHorizontallyConstarint];
}


@end
