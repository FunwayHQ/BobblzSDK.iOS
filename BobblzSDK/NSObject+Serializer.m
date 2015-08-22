//
//  NSObject+Serializer.m
//  BobblzSDK
//
//  Created by Denis Sancov on 22.08.15.
//  Copyright © 2015 funwayhq. All rights reserved.
//

#import "NSObject+Serializer.h"
#import <objc/runtime.h>

@implementation NSObject (Serializer)

- (NSData *)JSONData {
    id dict = [self jsonDataObjects];
    return [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
}

-(NSString *)JSONString {
    id dict = [self jsonDataObjects];
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
}

- (id)jsonDataObjects {
    id returnProperties = nil;
    if([self isKindOfClass:[NSArray class]]) {
        NSArray *selfArray = (id)self;
        NSUInteger length = [selfArray count];
        returnProperties = [NSMutableArray arrayWithCapacity:length];
        for(NSInteger i = 0; i < length; i++){
            [returnProperties addObject:[self dictionaryWithPropertiesOfObject:selfArray[i]]];
        }
    }
    else {
        returnProperties = [self dictionaryWithPropertiesOfObject: self];
    }
    return returnProperties;
}

- (NSDictionary *)dictionaryWithPropertiesOfObject:(id)obj {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSMutableArray *propertiesArray = [NSObject propertiesArrayFromObject:obj];
    
    for (NSUInteger i = 0; i < propertiesArray.count; i++) {
        NSString *key = propertiesArray[i];
        
        if (![obj valueForKey: key]) {
            continue;
        }
        
        if ([self isArray:obj key:key]) {
            dict[key] = [self arrayForObject:[obj valueForKey: key]];
        }
        else if ([self isDate:[obj valueForKey:key]]){
            dict[key] = [self dateForObject:[obj valueForKey: key]];
        }
        else if ([self isSystemObject:obj key:key]) {
            [dict setObject:[obj valueForKey:key] forKey:key];
        }
        else if ([NSObject isData:[obj valueForKey:key]]){
            NSData *encodedData = [[NSData alloc] initWithBase64EncodedData:[obj valueForKey:key] options:kNilOptions];
            NSString *encodedString = [encodedData base64EncodedStringWithOptions:kNilOptions];
            dict[key] = encodedString;
        }
        else {
            dict[key] = [self dictionaryWithPropertiesOfObject:[obj valueForKey: key]];
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

+(NSMutableArray *)propertiesArrayFromObject:(id)obj {
    
    NSMutableArray *props = [NSMutableArray array];
    
    if (!obj) {
        return props;
    }
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    for (NSInteger i = 0; i < count; i++) {
        [props addObject:[NSString stringWithUTF8String:property_getName(properties[i])]];
    }
    
    free(properties);
    
    NSString *superClassName = NSStringFromClass([obj superclass]);
    if (![superClassName isEqualToString:@"NSObject"]) {
        [props addObjectsFromArray:[NSObject propertiesArrayFromObject:[[NSClassFromString(superClassName) alloc] init]]];
    }
    
    return props;
}

- (BOOL)isArray:(id)obj key:(NSString *)key {
    return ([[obj valueForKey: key] isKindOfClass:[NSArray class]]);
}

- (BOOL)isArray:(id)obj {
    return ([obj isKindOfClass:[NSArray class]]);
}

- (BOOL)isDate:(id)obj {
    return ([obj isKindOfClass:[NSDate class]]);
}

- (BOOL)isData:(id)obj {
    return ([obj isKindOfClass:[NSData class]]);
}


- (NSMutableArray *)arrayForObject:(NSArray *)obj {
    NSMutableArray *objectsArray = [NSMutableArray array];
    for (NSInteger i = 0; i < obj.count; i++) {
        if ([self isArray:obj[i]]) {
            [objectsArray addObject:[self arrayForObject:obj[i]]];
        }
        else if ([self isDate:obj[i]]){
            [objectsArray addObject:[self dateForObject:obj[i]]];
        }
        else if ([self isSystemObject:obj[i]]) {
            [objectsArray addObject:obj[i]];
        }
        else {
            [objectsArray addObject:[self dictionaryWithPropertiesOfObject:obj[i]]];
        }
    }
    return objectsArray;
}


- (NSString *)dateForObject:(NSDate *)obj {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterMediumStyle;
    return [formatter stringFromDate:obj];
}

- (BOOL)isSystemObject:(id)obj key:(NSString *)key{
    return ([[obj valueForKey: key] isKindOfClass:[NSString class]] ||
            [[obj valueForKey: key] isKindOfClass:[NSNumber class]] ||
            [[obj valueForKey: key] isKindOfClass:[NSDictionary class]]);
}

- (BOOL)isSystemObject:(id)obj{
    return ([obj isKindOfClass:[NSString class]] ||
            [obj isKindOfClass:[NSNumber class]] ||
            [obj isKindOfClass:[NSDictionary class]]);
}

@end
