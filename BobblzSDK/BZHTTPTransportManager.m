//
//  BZHTTPTransportManager.m
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZHTTPTransportManager.h"
#import "BZHTTPRequestObject.h"

@implementation BZHTTPTransportManager


- (BZHTTPRequestObject *)returnHTTPRequestWithPostfixURL: (NSString *)postfixURL
                                              HTTPMethod: (BZHTTPMethod)httpMethod
                                           forModelClass: (Class<BZResourceProtocol>)modelClass
                                        withAttachedData: (NSData *)attachedData
{
    return [BZHTTPRequestObject
                requestObjectWithPostfixURL: postfixURL
                                 HTTPMethod: httpMethod
                              forModelClass: modelClass
                           withAttachedData: attachedData];
}

- (void)createResourceForModelClass: (Class<BZResourceProtocol>)modelClass
                           fromData: (NSData *)data
                          onSuccess: (void(^)(BZResponse *))success
                          onFailure: (void(^)(NSError *))failure
{
    BZHTTPRequestObject *requestObject = [self
                                            returnHTTPRequestWithPostfixURL: @"create/"
                                                                 HTTPMethod: POST
                                                              forModelClass: modelClass
                                                           withAttachedData: data];
    [requestObject
        executeOnSuccess: success
               onFailure: failure];
}

- (void)findAllByModelClass: (Class<BZResourceProtocol>)modelClass
          usingCriteriaData: (NSData *)criteriaData
                  onSuccess: (void (^)(BZResponse *))success
                  onFailure: (void (^)(NSError *))failure
{
    BZHTTPRequestObject *requestObject = [self
                                          returnHTTPRequestWithPostfixURL: @"list/"
                                                               HTTPMethod: GET
                                                            forModelClass: modelClass
                                                         withAttachedData: criteriaData];
    [requestObject
        executeOnSuccess: success
               onFailure: failure];
}


@end
