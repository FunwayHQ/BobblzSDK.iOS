//
//  ViewController.m
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
#import "BZJSONDataProcessor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TestModel *testModel = [[TestModel alloc] init];
    
    BZJSONDataProcessor *json = [[BZJSONDataProcessor alloc] init];
    [json encode: testModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
