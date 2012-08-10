//
//  NSObject+Phoenix.h
//  Clomp
//
//  Created by Andrei on 8/11/12.
//  Copyright (c) 2012 Whatevra. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *CamelCaseToUnderscores(NSString *input);
NSString *UnderscoresToCamelCase(NSString *underscores);

@interface NSObject (Phoenix)

- (void)riseFrom:(id)ashes;
- (id)ashes;
- (id)ashes:(BOOL)underscored;

@end
