//
//  BZResourceProtocol.h
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#ifndef BobblzSDK_BZResourceProtocol_h
#define BobblzSDK_BZResourceProtocol_h

#import "BZTransportProviderProtocol.h"

@protocol BZDataProcessorProtocol;

@protocol BZResourceProtocol <NSObject>

+ (id<BZTransportProviderProtocol>)getTransport;

@optional

+ (id<BZDataProcessorProtocol>)dataProcessor;

@end

#endif
