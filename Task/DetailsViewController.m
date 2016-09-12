//
//  DetailsViewController.m
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "DetailsViewController.h"
#import "Article.h"
#import "DataManager.h"
#import "NSLayoutConstraint+SmartConstraint.h"

@interface DetailsViewController () {
    UILabel *lblTitle;
    UIImageView *imgAvatar;
    UIImageView *imgLike;
    UITextView *txtAbstractInfo;
    NSString *wikiUrl;
    UIButton *btnRedirect;
    DataManager *dataManager;
}

@end

@implementation DetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    dataManager = [DataManager sharedManager];
    [self initElements];
    [self populateDetailsWithArticle:self.selectedArticle];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setAutoLayoutConstraints];
}

-(void) initElements {
    lblTitle = [[UILabel alloc]init];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:18.0]];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTitle];
    
    txtAbstractInfo = [[UITextView alloc]init];
    txtAbstractInfo.textContainer.heightTracksTextView = YES;
    txtAbstractInfo.textAlignment = NSTextAlignmentCenter;
    [txtAbstractInfo setFont:[UIFont boldSystemFontOfSize:14.0]];
    txtAbstractInfo.selectable = NO;
    txtAbstractInfo.editable = NO;
    txtAbstractInfo.scrollEnabled = NO;
    [self.view addSubview:txtAbstractInfo];

    imgAvatar = [[UIImageView alloc]init];
    imgAvatar.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgAvatar];
    
    imgLike = [[UIImageView alloc]init];
    imgLike.translatesAutoresizingMaskIntoConstraints = NO;
    imgLike.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgLike];

    
    
    btnRedirect = [[UIButton alloc]init];
    [btnRedirect setTitle:@"Load full article.." forState:UIControlStateNormal];
    [btnRedirect setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btnRedirect];
}




-(void) populateDetailsWithArticle: (Article*) article {
    lblTitle.text = article.title;
    imgAvatar.image = dataManager.selectedImage;
    [self setImageForLike:article.isFavourite];
    txtAbstractInfo.text = article.abstractInfo;
    wikiUrl = article.wikiUrlString;
    [btnRedirect addTarget:self action:@selector(redirectToWiki) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) redirectToWiki {
    NSURL *url = [NSURL URLWithString:wikiUrl];
    [[UIApplication sharedApplication] openURL:url];
}

-(void) setImageForLike: (BOOL) isLiked {
    NSString *liked = @"icon_like-red";
    NSString *notLiked = @"icon_like-gray";
    imgLike.image = isLiked ? [UIImage imageNamed:liked] : [UIImage imageNamed:notLiked];
}

#pragma mark - AutoLayout setup

-(void) setAutoLayoutConstraints {
    [self addTitleConstraints];
    [self addImageConstraints];
    [self addImageLikeConstraints];
    [self addTxtConstraints];
    [self addButtonConstraints];
}

-(void) addTitleConstraints {
    lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraints = [NSLayoutConstraint constraintWithItem:lblTitle
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.topLayoutGuide
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0
                                                                       constant:10];
    [self.view addConstraint:topConstraints];
    [NSLayoutConstraint setHeightConstraintToView:lblTitle withConstant:20];
    [NSLayoutConstraint setProportionalWidthToSuperview:lblTitle withMultiplier:0.7];
    [NSLayoutConstraint centerViewHorizontallyToSuperview:lblTitle];
}

-(void) addImageLikeConstraints {    
    NSLayoutConstraint *leadingConstarint = [NSLayoutConstraint constraintWithItem:imgLike
                                                                                  attribute:NSLayoutAttributeLeading
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:lblTitle
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                 multiplier:1.0
                                                                                   constant:20];
    
    [NSLayoutConstraint centerViewVertically:imgLike withOtherView:lblTitle];
    [NSLayoutConstraint setWidthConstraintToView:imgLike withConstant:25];
    [NSLayoutConstraint setHeightConstraintToView:imgLike withConstant:25];
    [self.view addConstraint:leadingConstarint];
}


-(void) addImageConstraints {
    imgAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraints = [NSLayoutConstraint constraintWithItem:imgAvatar
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:lblTitle
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0
                                                                       constant:10];
    
    NSLayoutConstraint *bottomConstraints = [NSLayoutConstraint constraintWithItem:imgAvatar
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:txtAbstractInfo
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:-20];
    
    [self.view addConstraints:@[topConstraints,bottomConstraints]];
    [NSLayoutConstraint setProportionalHeightToSuperview:imgAvatar withMultiplier:0.4];
    [NSLayoutConstraint setProportionalWidthToSuperview:imgAvatar withMultiplier:0.8];
    [NSLayoutConstraint centerViewHorizontallyToSuperview:imgAvatar];
}


-(void) addTxtConstraints {
    txtAbstractInfo.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bottomConstraints = [NSLayoutConstraint constraintWithItem:txtAbstractInfo
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:btnRedirect
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:-10];
    [self.view addConstraint:bottomConstraints];
    [NSLayoutConstraint setProportionalWidthToSuperview:txtAbstractInfo withMultiplier:0.8];
    [NSLayoutConstraint centerViewHorizontallyToSuperview:txtAbstractInfo];
}


-(void) addButtonConstraints {
    btnRedirect.translatesAutoresizingMaskIntoConstraints = NO;
     NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                 attribute:NSLayoutAttributeBottomMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:btnRedirect
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:20];
    [self.view addConstraint:bottomConstraint];
    [NSLayoutConstraint setHeightConstraintToView:btnRedirect withConstant:20];
    [NSLayoutConstraint setProportionalWidthToSuperview:btnRedirect withMultiplier:0.5];
    [NSLayoutConstraint centerViewHorizontallyToSuperview:btnRedirect];

}


@end
