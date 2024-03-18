#import "NSTimer+TBExtension.h"

@interface TBWeakTimerContainer : NSObject
@property (nonatomic, weak) id weakObj;
@end

@implementation TBWeakTimerContainer

- (instancetype)initWithWeakObject:(id)obj {
    self = [super init];
    if (self) {
        self.weakObj = obj;
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _weakObj;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSAssert(self.weakObj, @"weakTarget 比 timer 先释放");
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_weakObj respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (_weakObj) {
        return [super methodSignatureForSelector:aSelector];
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

@end

@implementation NSTimer (TBExtension)

+ (NSTimer *)tb_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    weakTarget:(_Nonnull id)weakTarget
                                      selector:(SEL)aSelector
                                      userInfo:(nullable id)userInfo
                                       repeats:(BOOL)yesOrNo {
    TBWeakTimerContainer *obj = [[TBWeakTimerContainer alloc] initWithWeakObject:weakTarget];
    return [NSTimer scheduledTimerWithTimeInterval:interval 
                                            target:obj
                                          selector:aSelector 
                                          userInfo:userInfo
                                           repeats:yesOrNo];
}

@end
