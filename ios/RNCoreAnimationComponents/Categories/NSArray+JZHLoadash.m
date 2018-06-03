//
//  NSArray+JZHLoadash.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "NSArray+JZHLoadash.h"

@implementation NSArray (JZHLoadash)

- (NSArray *)take:(NSUInteger)n {
    if (self.isEmpty) return [NSArray array];
    NSInteger size = MIN(self.count, n);
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:size];
    for (NSUInteger i = 0; i < size; i++) {
        [result addObject:self[i]];
    }
    return result;
}

- (void)each:(void (^)(id))block {
    for (id obj in self) {
        block(obj);
    }
}

- (void)eachWithIndex:(void (^)(NSUInteger, id))block {
    if (self.isEmpty) return;
    for (NSUInteger i = 0 ; i < self.count - 1; i++) {
        block(i, self[i]);
    }
}

- (id)find:(BOOL (^)(id))block {
    for (id value in self) {
        if (block(value)) {
            return value;
        }
    }
    return nil;
}

- (NSArray<NSDictionary<NSNumber *,id>*>*)zip:(NSArray *)secondArray {
    NSUInteger length = MIN(self.count, secondArray.count);
    NSMutableArray<NSDictionary<NSNumber *,id>*>* result = [NSMutableArray arrayWithCapacity:length];
    for (NSUInteger i = 0; i < length; i++) {
        [result addObject:@{@1: self[i], @2: secondArray[i]}];
    }
    return result;
}

- (BOOL)isEmpty {
    return self.count == 0;
}

- (NSArray *)map:(id (^)(id))block {
    if (self.isEmpty) return [NSArray array];
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:block(obj)];
    }];
    return result;
}


- (NSArray *)mapWithIndex:(id (^)(NSUInteger, id))block {
    if (self.isEmpty) return [NSArray array];
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:block(idx, obj)];
    }];
    return result;
}

- (NSArray *)without:(id)target {
    NSMutableArray* result = [NSMutableArray array];
    for (id obj in self) {
        if (![self isEqual:target]) {
            [result addObject:obj];
        }
    }
    return result;
}

- (NSArray *)flatten {
    if (self.isEmpty || ![self.firstObject isKindOfClass:[NSArray class]]) {
        return [NSArray array];
    }
    NSMutableArray* result = [NSMutableArray array];
    for (NSArray* array in self) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            [result addObject:item];
        }];
    }
    return result;
}

@end
