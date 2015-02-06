//
//  BZJSONDataProcessor.m
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZJSONDataProcessor.h"

@implementation BZJSONDataProcessor

- (NSString *)mimeType
{
    return @"application/json";
}

- (NSData *)encode:(NSObject *)model
{
    NSDictionary *dictionaryRepresentation = [BZUtils returnDictionaryRepresentationOfObject: model];
    
    if (dictionaryRepresentation == nil) {
        return nil;
    }
    NSError *serializationError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject: dictionaryRepresentation
                                                   options: kNilOptions
                                                     error: &serializationError];
    if (serializationError != nil) {
        NSLog(@"error on json encode %@", serializationError);
    }
    return data;
}

#warning TODO

- (id<BZResourceProtocol>)decode: (NSData *)data
              forModelClassNamed: (NSString *)modelClass
{
    if (data == nil) {
        return nil;
    }
    NSError *serializationError = nil;
    
    id responseObject = [NSJSONSerialization JSONObjectWithData: data
                                                        options: kNilOptions
                                                          error: &serializationError];
    
    id result = nil;
    
    
    if (serializationError != nil) {
        NSLog(@"error on json decode %@", serializationError);
    } else {
        if ([responseObject isKindOfClass: [NSDictionary class]]) {
            NSObject<BZResourceProtocol> *resource = [[NSClassFromString(modelClass) alloc] init];
            [responseObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [resource setValue:obj forKey: key];
            }];
            result = resource;
        }
    }
    
    return result;
}


@end
