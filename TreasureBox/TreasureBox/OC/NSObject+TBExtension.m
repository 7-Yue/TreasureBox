#import "NSObject+TBExtension.h"

void SwizzleMethod(Class cls,
                   SEL originalSelector,
                   SEL swizzledSelector,
                   BOOL isClassMethod) {
    Method originalMethod;
    Method swizzledMethod;
    
    if (isClassMethod) {
        originalMethod = class_getClassMethod(cls, originalSelector);
        swizzledMethod = class_getClassMethod(cls, swizzledSelector);
    } else {
        originalMethod = class_getInstanceMethod(cls, originalSelector);
        swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    }

    BOOL didAddMethod = class_addMethod(cls,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSObject (TBExtension)

- (void)setAssociatedValue:(id _Nullable) value key:(NSString * _Nonnull) key policy:(TBAssociationPolicy) policy {
    switch (policy) {
        case TBAssociationPolicy_Assign:
            objc_setAssociatedObject(self, @selector(key), value, OBJC_ASSOCIATION_ASSIGN);
            break;
        case TBAssociationPolicy_Weak: {
            __weak id w_value = value;
            id _Nullable (^handler)(void) = ^() {
                return w_value;
            };
            objc_setAssociatedObject(self, @selector(key), handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
            break;
        }
        case TBAssociationPolicy_Copy:
            objc_setAssociatedObject(self, @selector(key), value, OBJC_ASSOCIATION_COPY);
            break;
        case TBAssociationPolicy_CopyNonantomic:
            objc_setAssociatedObject(self, @selector(key), value, OBJC_ASSOCIATION_COPY_NONATOMIC);
            break;
        case TBAssociationPolicy_Retain:
            objc_setAssociatedObject(self, @selector(key), value, OBJC_ASSOCIATION_RETAIN);
            break;
        case TBAssociationPolicy_RetainNonantomic:
            objc_setAssociatedObject(self, @selector(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            break;
    }
}

- (id _Nullable)getAssociatedValueWithKey:(NSString * _Nonnull) key {
    id value = objc_getAssociatedObject(self, @selector(key));
    if ([value isKindOfClass:NSClassFromString(@"__NSMallocBlock__")]) {
        id _Nullable (^handler)(void) = value;
        return handler();
    }
    return value;
}

@end
