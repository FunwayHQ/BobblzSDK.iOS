//
//  TestModel.m
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (id)init
{
    self = [super init];
    if (self) {
        _first = @(100);
        _second = @[@"first", @"testString", @"das"];
        _third = @{@"key":@"someValue"};
        _someTestNumber = 14;
    }
    return self;
}

@end
