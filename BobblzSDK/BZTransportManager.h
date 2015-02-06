//
//  BZTransportManager.h
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZTransportProviderProtocol.h"
#import "BZResourceProtocol.h"

NSString *const BZHTTPTransportManager = @"BZHTTPTransportManager";

@interface BZTransportManager : NSObject

+ (id<BZTransportProviderProtocol>)getTransportWithIdentifier: (NSString *)transportIdentifier;


@end
