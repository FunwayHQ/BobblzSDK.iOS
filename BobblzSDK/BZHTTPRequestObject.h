//
//  BZHTTPRequestObject.h
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZRequestProtocol.h"
#import "BZResourceProtocol.h"

typedef NS_ENUM(NSUInteger, BZHTTPMethod) {
    POST = 1000,
    GET
};

@interface BZHTTPRequestObject : NSObject <BZRequestProtocol>

@property (strong, nonatomic, readonly) NSString *postfixURL;
@property (readonly) BZHTTPMethod httpMethod;
@property (strong, nonatomic, readonly) Class<BZResourceProtocol> modelClass;
@property (strong, nonatomic, readonly) NSData *attachedData;


- (instancetype)initWithPostfixURL: (NSString *)postfixURLString
                        HTTPMethod: (BZHTTPMethod)HTTPMethod
                     forModelClass: (Class<BZResourceProtocol>)modelClass
                  withAttachedData: (NSData *)attachedData;


+ (instancetype)requestObjectWithPostfixURL: (NSString *)postfixURLString
                                 HTTPMethod: (BZHTTPMethod)HTTPMethod
                              forModelClass: (Class<BZResourceProtocol>)modelClass
                           withAttachedData: (NSData *)attachedData;

- (NSURLRequest *)requestWithBaseApiURLString: (NSString *)baseApiURLString;

@end
