//
//  BZDataProcessorManager.h
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZDataProcessorProtocol.h"

typedef NS_ENUM(NSUInteger, BZDataProcessorType) {
    BZDataProcessorTypeJSON = 100,
    BZDataProcessorTypeXML
};

@interface BZDataProcessorManager : NSObject

+ (id<BZDataProcessorProtocol>)returnDataProcessorWithType: (BZDataProcessorType)dataProcessorType;
+ (id<BZDataProcessorProtocol>)returnDataProcessorForMimeType: (NSString *)mimeType;

@end
