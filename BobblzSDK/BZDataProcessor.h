//
//  BZDataProcessor.h
//  BobblzSDK
//
//  Created by Denis Sancov on 22.08.15.
//  Copyright © 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BZDataProcessorType) {
    BZJSONDataProcessor,
};

@protocol BZDataProcessorProtocol <NSObject>

- (NSString *)mimeType;
- (NSDictionary *)decode:(NSData *)input;
- (NSData *)encode:(id)input;

@end

@interface BZDataProcessor : NSObject

+ (id<BZDataProcessorProtocol>)processorWithType:(BZDataProcessorType)type;

@end

@interface BZJSONProcessor : NSObject <BZDataProcessorProtocol>

@end