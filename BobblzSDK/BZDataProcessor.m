//
//  BZDataProcessor.m
//  BobblzSDK
//
//  Created by Denis Sancov on 22.08.15.
//  Copyright © 2015 funwayhq. All rights reserved.
//

#import "BZDataProcessor.h"
#import "NSObject+Serializer.h"

@implementation BZDataProcessor

+ (NSMutableDictionary *)dataProcessors {
    static NSMutableDictionary *_dataProcessors;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataProcessors = [NSMutableDictionary dictionary];
    });
    return _dataProcessors;
}

+ (id<BZDataProcessorProtocol>)processorWithType:(BZDataProcessorType)type {
    id dataProcessor = [self dataProcessors][@(type)];
    if (dataProcessor == nil) {
        switch (type) {
            default: {
                dataProcessor = [[BZJSONProcessor alloc] init];
                break;
            }
        }
        [self dataProcessors][@(type)] = dataProcessor;
    }
    return dataProcessor;
}

@end


@implementation BZJSONProcessor

- (NSString *)mimeType {
    return @"application/json";
}

- (NSDictionary *)decode:(NSData *)input {
    NSError *serializationError = nil;
    id responseObject = [NSJSONSerialization JSONObjectWithData: input
                                                        options: kNilOptions
                                                          error: &serializationError];    
    if (serializationError != nil) {
        NSLog(@"error on json decode %@", serializationError);
    }
    return responseObject;
}

- (NSData *)encode:(id)input {
    if (input == nil) {
        NSLog(@"input is nil");
        return nil;
    }
    return [input JSONData];
}


@end