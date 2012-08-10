//
//  NSObject+Phoenix.m
//  Clomp
//
//  Created by Andrei on 8/11/12.
//  Copyright (c) 2012 Whatevra. All rights reserved.
//

#import "NSObject+Phoenix.h"
#import "MARTNSObject.h"

NSString *CamelCaseToUnderscores(NSString *input) {
    NSMutableString *output = [NSMutableString string];
    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    for (NSInteger idx = 0; idx < [input length]; idx += 1) {
        unichar c = [input characterAtIndex:idx];
        if ([uppercase characterIsMember:c]) {
            [output appendFormat:@"_%C", c ^ 32];
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

NSString *UnderscoresToCamelCase(NSString *underscores) {
    NSMutableString *output = [NSMutableString string];
    BOOL makeNextCharacterUpperCase = NO;
    for (NSInteger idx = 0; idx < [underscores length]; idx += 1) {
        unichar c = [underscores characterAtIndex:idx];
        if (c == '_') {
            makeNextCharacterUpperCase = YES;
        } else if (makeNextCharacterUpperCase) {
            [output appendString:[[NSString stringWithCharacters:&c length:1] uppercaseString]];
            makeNextCharacterUpperCase = NO;
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

@implementation NSObject (Phoenix)

- (void)riseFrom:(id)ashes {
    Class class = self.rt_class;
    do {
        for (RTProperty *property in class.rt_properties) {
            BOOL (^test_name)(NSString *) = ^(NSString *name) {
                if ([ashes valueForKey:name]) {
                    [self setValue:[ashes valueForKey:name] 
                            forKey:UnderscoresToCamelCase(name)];
                    return YES;
                } else {
                    return NO;
                }                
            };
            if (test_name([property name]) == NO) {
                test_name(CamelCaseToUnderscores([property name]));
            }
        }
        class = [class superclass];
    } while ([class isSubclassOfClass:[NSObject class]]);
}

- (id)ashes {
    return [self ashes:NO];
}

- (id)ashes:(BOOL)underscored {
    NSMutableDictionary *ashes = [NSMutableDictionary dictionary];

    Class class = self.rt_class;
    do {
        for (RTProperty *property in class.rt_properties) {
            if ([self valueForKey:[property name]] != nil) {
                if (underscored) { 
                    [ashes setValue:[self valueForKey:[property name]] 
                             forKey:CamelCaseToUnderscores([property name])];
                } else {
                    [ashes setValue:[self valueForKey:[property name]] 
                             forKey:[property name]];
                }
            }
        }
        class = [class superclass];
    } while ([class isSubclassOfClass:[NSObject class]]);

    return ashes;
}

@end
