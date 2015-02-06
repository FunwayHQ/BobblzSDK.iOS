//
//  BZTransportProviderProtocol.h
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#ifndef BobblzSDK_BZTransportProviderProtocol_h
#define BobblzSDK_BZTransportProviderProtocol_h
#import "BZResponse.h"

@protocol BZResourceProtocol;

@protocol BZTransportProviderProtocol <NSObject>

- (void)createResourceForModelClass: (Class<BZResourceProtocol>)modelClass
                           fromData: (NSData *)data
                          onSuccess: (void(^)(BZResponse *))success
                          onFailure: (void(^)(NSError *))failure;

- (void)updateResourceWithModelClass: (Class<BZResourceProtocol>)modelClass
                            fromData: (NSData *)data
                           onSuccess: (void(^)(BZResponse *))success
                           onFailure: (void(^)(NSError *))failure;

- (void)deleteResourceWithModelClass: (Class<BZResourceProtocol>)modelClass
                            fromData: (NSData *)data
                           onSuccess: (void(^)(BZResponse *))success
                           onFailure: (void(^)(NSError *))failure;

- (void)findAllByModelClass: (Class<BZResourceProtocol>)modelClass
          usingCriteriaData: (NSData *)criteriaData
                  onSuccess: (void (^)(BZResponse *))success
                  onFailure: (void (^)(NSError *))failure;

@end

#endif
