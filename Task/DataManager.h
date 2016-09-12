//
//  DataManager.h
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Article.h"


@interface DataManager : NSObject

@property (strong, nonatomic) NSMutableArray *articles;
@property (strong, nonatomic) NSMutableArray *favouriteArticles;
@property (strong, nonatomic) UIImage *selectedImage;

+ (id)sharedManager;

-(void) parseJson: (NSDictionary *) json withCompletionHandler: (void (^) (void)) completionHandler;
-(void) addArticleToFavorites: (Article*) article withComplitionHandler: (void  (^)(void)) completionHandler;
-(void) removeArticleFromFavorites: (Article*) article withComplitionHandler: (void  (^)(void)) completionHandler;



-(NSMutableArray *)articles;


@end
