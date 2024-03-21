#import <Foundation/Foundation.h>

@class TBTimer;

@protocol TBTimerEventDelegate <NSObject>

- (void)timerEventWithTimer:(TBTimer * _Nonnull) timer;

@end

@interface TBTimer : NSObject

/// 是否循环
@property (nonatomic, readonly, assign) BOOL isRepeat;
/// 计时间隔
@property (nonatomic, readonly, assign) NSTimeInterval timeInterval;
/// 延迟开始时长
@property (nonatomic, readonly, assign) NSTimeInterval delayInterval;


/// 创建一个计时器
/// - Parameters:
///   - timeInterval: 计时间隔
///   - delayInterval: 延迟开始时长
///   - queue: 队列
///   - isRepeat: 是否循环
- (instancetype _Nonnull)initWithTimeInterval:(NSTimeInterval) timeInterval
                                delayInterval:(NSTimeInterval) delayInterval
                                dispatchQueue:(dispatch_queue_t _Nonnull) queue
                                     isRepeat:(BOOL) isRepeat;


/// 添加、删除回调对象
- (void)addDelegate:(id <TBTimerEventDelegate> _Nullable) delegate;
- (void)removeDelegate:(id <TBTimerEventDelegate> _Nullable) delegate;


/// 开始、结束计时器
- (void)resume;
- (void)suspend;

@end

