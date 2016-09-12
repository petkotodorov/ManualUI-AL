//
//  DataManager.m
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()

//@property (strong, nonatomic) NSMutableArray *articles;

@end

@implementation DataManager



+ (id)sharedManager {
    static DataManager *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[DataManager alloc] init];
    });
    return __instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.articles = [NSMutableArray array];
        self.favouriteArticles = [NSMutableArray array];
        self.selectedImage = [[UIImage alloc]init];
    }
    return self;
}

-(void) parseJson: (NSDictionary *) json withCompletionHandler: (void (^) (void)) completionHandler{
    NSString *basepath = [json valueForKey:@"basepath"];
    NSArray *items = [json valueForKey:@"items"];
    
    for (NSDictionary *item in items) {
        NSString *title = [item valueForKey:@"title"];
        NSString *articleId = [[item valueForKey:@"id"] stringValue];
        NSString *abstractInfo = [item valueForKey:@"abstract"];
        NSString *thumbnail = [item valueForKey:@"thumbnail"];
        NSString *partialUrl = [item valueForKey:@"url"];
        NSString *wikiUrl = [NSString stringWithFormat:@"%@%@", basepath, partialUrl];
        
        Article *art = [[Article alloc]initWithTitle:title withId:articleId withAbstractInfo:abstractInfo withThumbnail:thumbnail andWikiUrl:wikiUrl];
        [self.articles addObject:art];
    }
    completionHandler();
}


-(void) addArticleToFavorites: (Article*) article withComplitionHandler: (void  (^)(void)) completionHandler {    
    for (int x = self.articles.count-1; x >= 0; x--) {
        Article* art = self.articles[x];
        if ([article.articleId isEqualToString:art.articleId]) {
            art.isFavourite = YES;
            [self.favouriteArticles addObject:art];
        }
    }
    completionHandler();
}

-(void) removeArticleFromFavorites: (Article*) article withComplitionHandler: (void  (^)(void)) completionHandler {
    for (int x = self.favouriteArticles.count-1; x >= 0; x--) {
        Article* art = self.favouriteArticles[x];
        if ([article.articleId isEqualToString:art.articleId]) {
            art.isFavourite = NO;
            [self.favouriteArticles removeObject:art];
        }
    }
    for (int x = self.articles.count-1; x >= 0; x--) {
        Article* art = self.articles[x];
        if ([article.articleId isEqualToString:art.articleId]) {
            art.isFavourite = NO;
        }
    }
    completionHandler();
}



@end
