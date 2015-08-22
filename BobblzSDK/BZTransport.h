//
//  BZTransport.h
//  BobblzSDK
//
//  Created by Denis Sancov on 22.08.15.
//  Copyright © 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BZTransportProtocol <NSObject>


@end

@interface BZTransport : NSObject

@end

@interface BZHTTPTransport : NSObject <BZTransportProtocol>

@end

@interface BZWebSocketTransport : NSObject <BZTransportProtocol>

@end