//
//  Article.h
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Article : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *articleId;
@property (strong, nonatomic) NSString *abstractInfo;
@property (strong, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSString *wikiUrlString;
@property (assign, nonatomic) BOOL isFavourite;
@property (assign, nonatomic) BOOL isExpanded;

-(id) initWithTitle: (NSString*) title withId:(NSString*) articleId withAbstractInfo: (NSString*) abstractInfo withThumbnail: (NSString*) thumbnail andWikiUrl: (NSString*) wikiUrl;

@end
