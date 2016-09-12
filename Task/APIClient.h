//
//  APIClient.h
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIClient : NSObject

//+ (id)sharedInstance;
+ (id)sharedClient;

-(void) getArticlesWithSuccess: (void (^) (NSDictionary *result)) success;
-(void) setImageFromUrl:(NSString*) urlString toImageView:(UIImageView*) toImgView;

@end
