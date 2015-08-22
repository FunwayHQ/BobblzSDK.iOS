//
//  ViewController.m
//  BobblzSDK
//
//  Created by Денис Саньков on 03.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "ViewController.h"
#import "BZTestObject.h"
#import "BZDataProcessor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BZJSONProcessor *proce = [BZDataProcessor processorWithType:BZJSONDataProcessor];
    [proce encode: [[BZTestObject alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
