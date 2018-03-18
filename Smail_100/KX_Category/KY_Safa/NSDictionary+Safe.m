//
//  NSDictionary+Safe.m
//  lisong
//
//  Created by lisong on 2017/4/1.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "NSDictionary+Safe.h"

#import "NSObject+Runtime.h"
@implementation NSDictionary (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSPlaceholderDictionary") swapMethod:@selector(initWithObjects:forKeys:count:)
                                                      currentMethod:@selector(ls_initWithObjects:forKeys:count:)];
    });

}

- (instancetype)ls_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++)
    {
        id key = keys[i];
        id obj = objects[i];
        if (!key)
        {
            continue;
        }
        if (!obj)
        {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    
    return [self ls_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end


@implementation NSMutableDictionary (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSDictionaryM") swapMethod:@selector(setObject:forKey:)
                                            currentMethod:@selector(ls_setObject:forKey:)];
    });

}

- (void)ls_setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (!anObject)
    {
        showAlertMasse(@"setObject: forKey:");
        return;
    }
    if (!aKey)
    {
        showAlertMasse(@"setObject: forKey:");
        return;
    }
    [self ls_setObject:anObject forKey:aKey];
}

@end
