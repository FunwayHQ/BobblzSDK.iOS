//
//  BZDataProcessorManager.m
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZDataProcessorManager.h"
#import "BZJSONDataProcessor.h"

@implementation BZDataProcessorManager

+ (NSDictionary *)availableDataProcessors
{
    static NSDictionary *dataProcessors = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataProcessors = @{
                            @"application/json": @(BZDataProcessorTypeJSON),
                            @"application/xml" : @(BZDataProcessorTypeXML)
                          };
    });
    
    return dataProcessors;
}

+ (id<BZDataProcessorProtocol>)returnDataProcessorWithType: (BZDataProcessorType)dataProcessorType
{
    id <BZDataProcessorProtocol> dataProcessor;
    switch (dataProcessorType) {
        case BZDataProcessorTypeJSON: {
            dataProcessor = [[BZJSONDataProcessor alloc] init];
            break;
        }
        default:
            break;
    }
    return dataProcessor;
}

+ (BZDataProcessorType)getDataProcessorEnumTypeByMimeTypeString: (NSString *)mimeType
{
    NSNumber *dataProcessorType = [[self availableDataProcessors] valueForKey: mimeType];
    return (dataProcessorType != nil) ? [dataProcessorType unsignedIntegerValue] : BZDataProcessorTypeJSON;
}

+ (id<BZDataProcessorProtocol>)returnDataProcessorForMimeType: (NSString *)mimeType
{
    BZDataProcessorType dataProcessorType = [self getDataProcessorEnumTypeByMimeTypeString: mimeType];
    return [self returnDataProcessorWithType: dataProcessorType];
}

@end
