//
//  GEApiManager.m
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

#import "GoEuroApi.h"
#import "Constant.h"

@interface GoEuroApi ()
@property (nonatomic,strong) NSOperationQueue *operationQueue;
@end

@implementation GoEuroApi

+ (instancetype)sharedAPI {
    
    static GoEuroApi *api=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[GoEuroApi alloc] init];
        api.operationQueue=[[NSOperationQueue alloc] init];
    });
    return api;
}

- (NSString*)baseURL {
    
    return BASE_URL;
}

- (void)getBusDataWithCompletion:(GoEuroApiCallCompletion)completion {
    [self sendHTTPRequestWithpath:@"37yzm" completion:completion];
}

#pragma mark - Helper Methods.

- (void)sendHTTPRequestWithpath:(NSString*)path
                       completion:(GoEuroApiCallCompletion)completion {
    
    NSString *url=[self baseURL];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,path]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:self.operationQueue
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               
                               NSInteger statusCode=[(NSHTTPURLResponse*)response statusCode];
                               if (connectionError) {
                                   completion(nil,statusCode,connectionError);
                                   
                               }else {
                                   
                                   completion([GoEuroApi serializetoJSON:data],
                                              statusCode,
                                              nil);
                               }
                               
                           }];
}


+ (id)serializetoJSON:(NSData*)data {
    
    if (data) {
        
        NSError *error=nil;
        id JSON=[NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&error];
        if (!error) {
            return JSON;
        }else{
            
            NSLog(@"JSON PARSING FAILED %@",error);
        }
    }
    return nil;
}

+ (NSData*)serialize:(id)JSON {
    
    if (JSON) {
        
        NSError *error =nil;
        NSData *data=[NSJSONSerialization dataWithJSONObject:JSON
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&error];
        if (!error) {
            return data;
        }else{
            
            NSLog(@"Error in serializing json %@",error);
        }
    }
    
    return nil;
}

- (NSString *)queryPathForParam:(NSDictionary *)param {
    NSString *queryPath = @"?";
    for (NSString *key in param.allKeys) {
        queryPath = [queryPath stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[param objectForKey:key]]];
        queryPath = [queryPath stringByAppendingString:@"&"];
    }
    
    return [queryPath substringToIndex:[queryPath length] - 1];
}


@end
