#import <Foundation/Foundation.h>
#import <objc/runtime.h>


/// 方法交换
/// - Parameters:
///   - cls: 交换类
///   - originalSelector: 原始方法
///   - swizzledSelector: 交换方法
///   - isClassMethod: 是否是类方法
FOUNDATION_EXTERN void SwizzleMethod(Class _Nonnull cls,
                                     SEL _Nonnull originalSelector,
                                     SEL _Nonnull swizzledSelector,
                                     BOOL isClassMethod);

typedef NS_ENUM(NSInteger, TBAssociationPolicy) {
    TBAssociationPolicy_Assign              = 1,
    TBAssociationPolicy_Weak                = 2,
    TBAssociationPolicy_Copy                = 3,
    TBAssociationPolicy_CopyNonantomic      = 4,
    TBAssociationPolicy_Retain              = 5,
    TBAssociationPolicy_RetainNonantomic    = 6
};

@interface NSObject (TBExtension)

/// 设置当前对象的关联属性
/// - Parameters:
///   - value: 关联值
///   - key: 关联key
///   - policy: 关联策略
- (void)setAssociatedValue:(id _Nullable) value key:(NSString * _Nonnull) key policy:(TBAssociationPolicy) policy;


/// 获取关联值
/// - Parameter key: 关联key
- (id _Nullable)getAssociatedValueWithKey:(NSString * _Nonnull) key;

@end
