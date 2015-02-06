//
//  BZUtils.m
//  BobblzSDK
//
//  Created by Денис Саньков on 04.02.15.
//  Copyright (c) 2015 funwayhq. All rights reserved.
//

#import "BZUtils.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation BZUtils

+ (NSDictionary *)returnDictionaryRepresentationOfObject: (NSObject *)object
{
    NSMutableDictionary *tmpDictionary = [NSMutableDictionary dictionary];
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);

    NSSet *blackList = [NSSet setWithArray: @[@"debugDescription", @"description", @"hash", @"superclass"]];
    
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString: property_getName(property)
                                                    encoding: [NSString defaultCStringEncoding]];
        if (![blackList intersectsSet: [NSSet setWithObject: propertyName]]) {
            [tmpDictionary setValue: [object valueForKey: propertyName]
                             forKey: propertyName];
        }
    }
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary: tmpDictionary];
}

+ (NSDictionary *)returnCommonRequestHeaders
{
    NSMutableArray *acceptLanguagesComponents = [NSMutableArray array];
    [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat q = 1.0f - (idx * 0.1f);
        [acceptLanguagesComponents addObject:[NSString stringWithFormat:@"%@;q=%0.1g", obj, q]];
        *stop = q <= 0.5f;
    }];
    
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    
    return @{
                @"Accept-Language" : [acceptLanguagesComponents componentsJoinedByString: @","],
                @"User-Agent": userAgent,
            };

}

@end
