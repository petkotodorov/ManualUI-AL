//
//  ArticleTableViewCell.h
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleTableViewCell;

@protocol ArticleCellDelegate <NSObject>

//-(void) reloadExpandedRow: (BOOL) isExpanded;
-(void) reloadCell: (ArticleTableViewCell*) cell expanded:(BOOL) isExpanded;

@end

@interface ArticleTableViewCell : UITableViewCell

@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UIImageView *imgAvatar;
@property(strong, nonatomic) UIImageView *imgLike;
@property(strong, nonatomic) UITextView *txtDescription;
@property(strong, nonatomic) UIButton *btnFavourite;
@property(assign, nonatomic) BOOL isExpanded;
@property(weak, nonatomic) id<ArticleCellDelegate> delegate;

@end
