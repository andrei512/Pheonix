Pheonix
=======

category that makes life easier when parsing web services

Dependencies
============

https://github.com/mikeash/MAObjCRuntime

Features
========

- populates properties from a NSDictionary or any other key value compliant object
- automatically converts from underscore_separated_names to camelCaseNames :) 

Example
=======

```Objective-c
@interface User

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;

@property (nonatomic, retain) NSNumber *age;

@end

...

NSDictionary *info = [NSDictionary withObjectsAndKeys:
                       @"Andrei", @"firstName",
                       @"Puni", @"last_name",
                       [NSNumber numberWithInt:21], @"age",
                       nil];
                       
User *user = [[User new] riseFrom:info];

// now user.firstName is @"Andrei", user.lastName is @"Puni" and user.age is @21

```