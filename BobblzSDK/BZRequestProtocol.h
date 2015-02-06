//
//  BZRequestProtocol.h
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#ifndef BobblzSDK_BZRequestProtocol_h
#define BobblzSDK_BZRequestProtocol_h
#import "BZResponse.h"

@protocol BZRequestProtocol <NSObject>

- (void)executeOnSuccess: (void(^)(BZResponse *))success
               onFailure: (void(^)(NSError *))failure;

@end

#endif
