//
//  BZPacket.m
//  BobblzSDK
//
//  Created by Denis Sancov on 22.08.15.
//  Copyright © 2015 funwayhq. All rights reserved.
//

#import "BZPacket.h"

@implementation BZPacket

+ (instancetype)packetForMethod:(BZMethodType)method {
    return [BZPacket packetForMethod:method withSuffixURL:nil];
}

+ (instancetype)packetForMethod:(BZMethodType)method withSuffixURL:(NSString *)suffixURL {
    return [[BZPacket alloc] initWithMethod:method suffixURL:suffixURL];
}

- (instancetype)initWithMethod:(BZMethodType)method suffixURL:(NSString *)suffixURL {
    self = [super init];
    if (self) {
        _method = method;
        _suffixURL = suffixURL;
    }
    return self;
}

@end
