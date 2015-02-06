//
//  BZHTTPRequestObject.m
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZHTTPRequestObject.h"
#import "BZUtils.h"
#import "BZDataProcessorProtocol.h"
#import "BZHTTPClient.h"

@implementation BZHTTPRequestObject

+ (instancetype)requestObjectWithPostfixURL: (NSString *)postfixURLString
                                 HTTPMethod: (BZHTTPMethod)HTTPMethod
                              forModelClass: (Class<BZResourceProtocol>)modelClass
                           withAttachedData: (NSData *)attachedData
{
    return [[BZHTTPRequestObject alloc]
                            initWithPostfixURL: postfixURLString
                                    HTTPMethod: HTTPMethod
                                 forModelClass: modelClass
                              withAttachedData: attachedData];
}

- (instancetype)initWithPostfixURL: (NSString *)postfixURLString
                        HTTPMethod: (BZHTTPMethod)HTTPMethod
                     forModelClass: (Class<BZResourceProtocol>)modelClass
                  withAttachedData: (NSData *)attachedData
{
    self = [super init];
    if (self) {
        _postfixURL = postfixURLString;
        _httpMethod = HTTPMethod;
        _modelClass = modelClass;
        _attachedData = attachedData;
    }
    return self;
}

- (NSString *)getHTTPMethodByBZHTTPMethod: (BZHTTPMethod)bzHTTPMethod
{
    NSString *httpMethod = nil;
    switch (bzHTTPMethod) {
        case POST: {
            httpMethod = @"POST";
            break;
        }
        case GET: {
            httpMethod = @"GET";
            break;
        }
    }
    return httpMethod;
}


- (NSURLRequest *)requestWithBaseApiURLString: (NSString *)baseApiURLString
{
    NSString *finalURLString = [NSString stringWithFormat:@"%@/%@/%@",baseApiURLString, NSStringFromClass(_modelClass), _postfixURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                            requestWithURL: [NSURL URLWithString: finalURLString]];
    [request setAllHTTPHeaderFields: [BZUtils returnCommonRequestHeaders]];
    
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSString *contentType = [NSString stringWithFormat:@"%@; charset=%@",[[_modelClass dataProcessor] mimeType], charset];
    [request setValue: contentType forHTTPHeaderField: @"Content-Type"];
    
    [request setHTTPMethod: [self getHTTPMethodByBZHTTPMethod: _httpMethod]];
    [request setHTTPBody: _attachedData];
    

    return request;
}

- (void)executeOnSuccess: (void (^)(BZResponse *))success
               onFailure: (void (^)(NSError *))failure
{
    [[BZHTTPClient client] performRequest: self
                                onSuccess: success
                                onFailure: failure];
}

@end
