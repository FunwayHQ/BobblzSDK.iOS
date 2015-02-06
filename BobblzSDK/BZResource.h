//
//  BZResource.h
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZResourceProtocol.h"
#import "BZCriteria.h"

@interface BZResource : NSObject

@property (strong, nonatomic, readonly) id<BZResourceProtocol> resource;

- (instancetype)initWithResource: (id<BZResourceProtocol>)resource;

- (void)createOnSuccess: (void(^)(void))success
              onFailure: (void(^)(NSError *))failure;

- (void)updateOnSuccess: (void(^)(void))success
              onFailure: (void(^)(NSError *))failure;

- (void)deleteOnSuccess: (void(^)(void))success
              onFailure: (void(^)(NSError *))failure;

+ (void)findAllByModelClass: (Class<BZResourceProtocol>)modelClass
                  onSuccess: (void(^)(NSArray *))success
                  onFailure: (void(^)(NSError *))failure;

+ (void)findAllByModelClass: (Class<BZResourceProtocol>)modelClass
              usingCriteria: (BZCriteria *)criteria
                  onSuccess: (void (^)(NSArray *))success
                  onFailure: (void (^)(NSError *))failure;

@end
