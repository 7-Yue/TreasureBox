#import <Foundation/Foundation.h>

@interface NSTimer (TBExtension)

/// 定时器
/// - Parameters:
///   - interval: 间隔
///   - weakTarget: 弱引用的target
///   - aSelector: 函数
///   - userInfo: 信息
///   - yesOrNo: 是否重复
+ (NSTimer *_Nonnull)tb_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                            weakTarget:(_Nonnull id)weakTarget
                                              selector:(_Nonnull SEL)aSelector
                                              userInfo:(nullable id)userInfo
                                               repeats:(BOOL)yesOrNo;
@end

