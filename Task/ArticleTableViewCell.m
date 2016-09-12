//
//  ArticleTableViewCell.m
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "NSLayoutConstraint+SmartConstraint.h"



@implementation ArticleTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initElements];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Actions

- (void) likeArticle: (UIButton*) sender {
    sender.selected = !sender.selected;
}

-(void) handleLongPress: (UILongPressGestureRecognizer*) longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self.delegate reloadCell:self expanded:!self.isExpanded];
    }
}

#pragma mark - Initialization



-(void) initElements {
    self.imgAvatar = [[UIImageView alloc] init];
    self.imgAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgAvatar.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imgAvatar];
    
    self.txtDescription = [[UITextView alloc]init];
//    self.txtDescription.backgroundColor = [UIColor lightGrayColor];
    self.txtDescription.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtDescription.font = [UIFont systemFontOfSize:15.0];
    self.txtDescription.textAlignment = NSTextAlignmentCenter;
    self.txtDescription.editable = NO;
    self.txtDescription.scrollEnabled = NO;
    for (UIGestureRecognizer *recognizer in self.txtDescription.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
            recognizer.enabled = NO;
        }
    }
    [self.txtDescription addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)]];
    [self.contentView addSubview:self.txtDescription];
    
    self.lblTitle = [[UILabel alloc]init];
    self.lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.lblTitle setFont:[UIFont boldSystemFontOfSize:16.0]];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.lblTitle];
    
    self.btnFavourite = [[UIButton alloc]init];
    self.btnFavourite.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnFavourite.titleLabel.numberOfLines = 2;
    self.btnFavourite.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnFavourite.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.btnFavourite setTitle:@"Add to favorites" forState:UIControlStateNormal];
    [self.btnFavourite setTitle:@"Remove" forState:UIControlStateSelected];
    [self.btnFavourite setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnFavourite.layer.borderWidth = 2.0;
    self.btnFavourite.layer.borderColor = [[UIColor redColor]CGColor];
    [self.btnFavourite.layer setMasksToBounds:YES];
    [self.btnFavourite.layer setCornerRadius:4.0f];
    [self.contentView addSubview:self.btnFavourite];
}

-(void) setupConstraints {
    [self setImageConstraints];
    [self setTitleConstraints];
    [self setBtnConstraints];
    [self setTextFieldConstraints];
}

#pragma mark - AutoLayout setup


-(void) setBtnConstraints {
    
    
    
    
    NSLayoutConstraint *trailingSpaceConstarint = [NSLayoutConstraint constraintWithItem:self.btnFavourite
                                                                                 attribute:NSLayoutAttributeTrailing
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.contentView
                                                                                 attribute:NSLayoutAttributeTrailing
                                                                                multiplier:1.0
                                                                                  constant:-5];
    
    NSLayoutConstraint *horizontalSpaceConstarint = [NSLayoutConstraint constraintWithItem:self.btnFavourite
                                                                                 attribute:NSLayoutAttributeLeading
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.lblTitle
                                                                                 attribute:NSLayoutAttributeTrailing
                                                                                multiplier:1.0
                                                                                  constant:15];
    [NSLayoutConstraint centerViewVertically:self.btnFavourite withOtherView:self.lblTitle];
    [NSLayoutConstraint setHeightConstraintToView:self.btnFavourite withConstant:40];
    [NSLayoutConstraint setWidthConstraintToView:self.btnFavourite withConstant:70];
    
    [self.contentView addConstraints:@[trailingSpaceConstarint,horizontalSpaceConstarint]];

}

-(void) setTitleConstraints {    
    NSLayoutConstraint *horizontalSpaceConstarint = [NSLayoutConstraint constraintWithItem:self.lblTitle
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.imgAvatar
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                   multiplier:1.0
                                                                                     constant:15];
    
    [NSLayoutConstraint centerViewVertically:self.lblTitle withOtherView:self.imgAvatar];
    [self.contentView addConstraint:horizontalSpaceConstarint];
}

-(void) setTextFieldConstraints {
    
    NSLayoutConstraint *topConstraints = [NSLayoutConstraint constraintWithItem:self.imgAvatar
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.txtDescription
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:-5];
    
    NSLayoutConstraint *bottomConstraints = [NSLayoutConstraint constraintWithItem:self.txtDescription
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0
                                                                       constant:-2];
    
    [NSLayoutConstraint centerViewHorizontallyToSuperview:self.txtDescription];
    [NSLayoutConstraint setWidthConstraintToView:self.txtDescription withConstant:200];
    [self.contentView addConstraints:@[bottomConstraints, topConstraints]];

}

-(void) setImageConstraints {
    NSLayoutConstraint *topConstraints = [NSLayoutConstraint constraintWithItem:self.imgAvatar
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:5];
    
    NSLayoutConstraint *leadingConstraints = [NSLayoutConstraint constraintWithItem:self.imgAvatar
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.0
                                                                       constant:5];
    
    
    [NSLayoutConstraint setHeightConstraintToView:self.imgAvatar withConstant:55];
    [NSLayoutConstraint setWidthConstraintToView:self.imgAvatar withConstant:55];
    [self.contentView addConstraints:@[topConstraints,leadingConstraints]];
}

@end
