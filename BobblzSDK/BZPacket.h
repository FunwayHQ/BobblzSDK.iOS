//
//  BZPacket.h
//  BobblzSDK
//
//  Created by Denis Sancov on 22.08.15.
//  Copyright © 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZMethodType.h"

@interface BZPacket : NSObject

@property (nonatomic, readonly) BZMethodType method;
@property (nonatomic, readonly) NSInteger status;
@property (copy, nonatomic, readonly) NSString *suffixURL;
@property (strong, nonatomic) NSObject *object;

+ (instancetype)packetForMethod:(BZMethodType)method;
+ (instancetype)packetForMethod:(BZMethodType)method withSuffixURL:(NSString *)suffixURL;

@end
