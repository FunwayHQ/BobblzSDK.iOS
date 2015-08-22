//
//  NSObject+Serializer.h
//  BobblzSDK
//
//  Created by Denis Sancov on 22.08.15.
//  Copyright © 2015 funwayhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Serializer)

- (NSData *)JSONData;
- (NSString *)JSONString;

@end
