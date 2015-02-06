//
//  BZResponse.m
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZResponse.h"

@implementation BZResponse

- (instancetype)initWithData: (NSData *)responseData
                    response: (NSURLResponse *)response
{
    self = [super init];
    if (self) {
        _responseData = responseData;
        _response = response;
    }
    return self;
}

@end
