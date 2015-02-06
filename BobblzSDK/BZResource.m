//
//  BZResource.m
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZResource.h"
#import "BZDataProcessorManager.h"

@interface BZResource ()

@property (strong, nonatomic)  id <BZTransportProviderProtocol> transportProvider;
@property (strong, nonatomic)  id <BZDataProcessorProtocol> dataProcessor;

@end

@implementation BZResource

- (instancetype)initWithResource: (id<BZResourceProtocol>)resource
{
    self = [super init];
    if (self) {
        _resource = resource;
        _transportProvider = [resource getTransport];
        
        if ([self.resource respondsToSelector: @selector(dataProcessor)]) {
            _dataProcessor = [resource dataProcessor];
        } else {
            _dataProcessor = [BZDataProcessorManager returnDataProcessorWithType: BZDataProcessorTypeJSON];
        }
        
    }
    return self;
}

- (void)createOnSuccess: (void(^)(void))success
              onFailure: (void(^)(NSError *))failure
{
    [_transportProvider
        createResourceForModelClass: [self.resource class]
                           fromData: [_dataProcessor encode: self.resource]
                          onSuccess: ^(BZResponse *response) {
                              
                        } onFailure: failure];
}

- (void)updateOnSuccess: (void(^)(void))success
              onFailure: (void(^)(NSError *))failure
{
    /*[_transportProvider
        updateResourceWithClassNamed: NSStringFromClass([self.resource class])
                            fromData: [_dataProcessor encode: self.resource]
                           onSuccess: success
                           onFailure: failure];*/
}

- (void)deleteOnSuccess: (void(^)(void))success
              onFailure: (void(^)(NSError *))failure
{
   /* [_transportProvider
        deleteResourceWithClassNamed: NSStringFromClass([self.resource class])
                            fromData: [_dataProcessor encode: self.resource]
                           onSuccess: success
                           onFailure: failure];*/
}

+ (void)findAllByModelClass: (Class<BZResourceProtocol>)modelClass
                  onSuccess: (void(^)(NSArray *))success
                  onFailure: (void(^)(NSError *))failure
{
    [self findAllByModelClass: modelClass
                usingCriteria: nil
                    onSuccess: success
                    onFailure: failure];
}

+ (void)findAllByModelClass: (Class<BZResourceProtocol>)modelClass
              usingCriteria: (BZCriteria *)criteria
                  onSuccess: (void (^)(NSArray *))success
                  onFailure: (void (^)(NSError *))failure
{
    NSAssert([(Class)modelClass conformsToProtocol: @protocol(BZResourceProtocol)],
             @"Class must conform to BZResourceProtocol");
    
    id <BZTransportProviderProtocol> transportProvider = [modelClass getTransport];
    
    id <BZDataProcessorProtocol> dataProcessor;
    
    if ([(Class)modelClass respondsToSelector: @selector(dataProcessor)]) {
        dataProcessor = [modelClass dataProcessor];
    } else {
        dataProcessor = [BZDataProcessorManager returnDataProcessorWithType: BZDataProcessorTypeJSON];
    }
    
    [transportProvider
        findAllByModelClass: modelClass
          usingCriteriaData: [dataProcessor encode: criteria]
                  onSuccess: ^(BZResponse *response) {
        
                } onFailure: failure];
    
}


@end
