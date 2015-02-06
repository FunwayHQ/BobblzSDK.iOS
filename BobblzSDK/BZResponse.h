//
//  BZResponse.h
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZResponse : NSObject

@property (strong, nonatomic, readonly) NSData *responseData;
@property (strong, nonatomic, readonly) NSURLResponse *response;

- (instancetype)initWithData: (NSData *)responseData
                    response: (NSURLResponse *)response;

@end
