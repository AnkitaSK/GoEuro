//
//  GEApiManager.h
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoEuroApi : NSObject
typedef void(^GoEuroApiCallCompletion) (id response,NSInteger HTTPStatusCode,NSError *error);

+ (instancetype)sharedAPI;
- (void)getBusDataWithCompletion:(GoEuroApiCallCompletion)completion;
@end
