//
//  TestModel.h
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZResourceProtocol.h"

@interface TestModel : NSObject <BZResourceProtocol>

@property (nonatomic, strong) NSNumber *first;
@property (nonatomic, strong) NSArray *second;
@property (nonatomic, strong) NSDictionary *third;
@property NSInteger someTestNumber;

@end
