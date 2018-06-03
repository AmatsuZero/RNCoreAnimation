//
//  NSArray+JZHLoadash.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<Type> (JZHLoadash)

@property(nonatomic, readonly, assign, getter=isEmpty)BOOL empty;

- (NSArray<Type>*)take:(NSUInteger)count;

- (void)each:(void(^)(Type))block;

- (void)eachWithIndex:(void(^)(NSUInteger, id))block;

- (_Nullable Type)find:(BOOL(^)(Type))block;

- (NSArray<NSDictionary<NSNumber*, id>*>*)zip:(NSArray *)secondArray;

- (NSArray*)mapWithIndex:(id(^)(NSUInteger, Type))block;

- (NSArray*)map:(id(^)(Type))block;

- (NSArray<Type>*)without:(Type)target;

- (NSArray*)flatten;

@end
