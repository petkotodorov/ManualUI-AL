//
//  DetailsViewController.h
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Article *selectedArticle;

@end
