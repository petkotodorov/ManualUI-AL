//
//  APIClient.m
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "APIClient.h"
#import "DataManager.h"
#import <UIKit/UIKit.h>



@implementation APIClient

const NSString * baseUrl = @"https://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1";
const NSString * categoryParam = @"Characters";
const int limitParam = 75;


+ (id)sharedClient {
    static APIClient *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[APIClient alloc] init];
    });
    return __instance;
}


-(void) getArticlesWithSuccess: (void (^) (NSDictionary *result)) success {
//    NSDictionary *params = @{@"category" : categoryParam, @"limit" : [NSNumber numberWithInt:limitParam]};
    NSString *fullString = [NSString stringWithFormat:@"%@&category=%@&limit=%d", baseUrl, categoryParam, limitParam];
    NSLog(@"%@", fullString);
    NSURL *url = [NSURL URLWithString:fullString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        success(json);
    }];
    
    [dataTask resume];
}

-(void)setImageFromUrl:(NSString*) urlString toImageView: (UIImageView*) toImgView {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       UIImage *downloadedImage = [UIImage imageWithData:
                                                                                   [NSData dataWithContentsOfURL:location]];
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [toImgView setImage:downloadedImage];
                                                       });
                                                   }];
    [downloadPhotoTask resume];
    
}



@end
