//
//  BZTransportManager.m
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZTransportManager.h"

@implementation BZTransportManager

+ (NSMutableDictionary *)availableTransports
{
    static NSMutableDictionary *transports = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transports = [NSMutableDictionary dictionary];
    });
    
    return transports;
}


+ (id<BZTransportProviderProtocol>)getTransportWithIdentifier: (NSString *)transportIdentifier
{
    NSDictionary *availableTransports = [self availableTransports];
    id<BZTransportProviderProtocol> transportManager = [availableTransports valueForKey: transportIdentifier];
    if (transportManager == nil) {
        transportManager = [self returnTransportProviderInstanceWithIdentifier: transportIdentifier];
        [availableTransports setValue: transportManager forKey: transportIdentifier];
    }
    return transportManager;
}

+ (id<BZTransportProviderProtocol>)returnTransportProviderInstanceWithIdentifier: (NSString *)identifier
{
    return [[NSClassFromString(identifier) alloc] init];
}

@end
