//
//  Article.m
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "Article.h"

@implementation Article

-(id) initWithTitle: (NSString*) title withId:(NSString*) articleId withAbstractInfo: (NSString*) abstractInfo withThumbnail: (NSString*) thumbnail andWikiUrl: (NSString*) wikiUrl {
    self = [super init];
    if (self) {
        self.title = title;
        self.articleId = articleId;
        self.abstractInfo = abstractInfo;
        self.thumbnail = thumbnail;
        self.wikiUrlString = wikiUrl;
    }
    return self;
}



@end
