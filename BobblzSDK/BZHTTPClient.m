/*
    BZHTTPClient.m
    bobblz
 
    The MIT License (MIT)
 
    Created by Denis Sancov on 24.01.15.
    Copyright (c) 2015 Funway Interactive LLC
 
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
 
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
 
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
*/


#import "BZHTTPClient.h"

@implementation BZHTTPClient

+ (instancetype)client
{
    static BZHTTPClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[BZHTTPClient alloc] init];
    });
    return __sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)performRequest: (BZHTTPRequestObject *)requestObject
             onSuccess: (void(^)(BZResponse *))success
             onFailure: (void(^)(NSError *))failure
{
    [[_session
        dataTaskWithRequest: [requestObject requestWithBaseApiURLString: baseAPIURLString]
          completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
              if (error != nil) {
                  if (failure != nil) {
                      failure(error);
                  }
              } else {
                  success([[BZResponse alloc] initWithData: data
                                                  response: response]);
              }
          }] resume];
}

@end
