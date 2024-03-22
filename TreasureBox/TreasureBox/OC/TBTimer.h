#import <Foundation/Foundation.h>

@class TBTimer;

typedef NS_ENUM(NSInteger, TBTimerStatus) {
    TBTimerStatus_Prepare                   = 1,
    TBTimerStatus_Working                   = 2,
    TBTimerStatus_Suspend                   = 3,
    TBTimerStatus_End                       = 4,
};

@protocol TBTimerEventDelegate <NSObject>

- (void)timerEventWithTimer:(TBTimer * _Nonnull) timer;

@end

/// 定时器
@interface TBTimer : NSObject

/// 是否循环
@property (nonatomic, readonly, assign) BOOL isRepeat;
/// 计时间隔
@property (nonatomic, readonly, assign) NSTimeInterval timeInterval;
/// 延迟开始时长
@property (nonatomic, readonly, assign) NSTimeInterval delayInterval;
/// 计时器状态
@property (nonatomic, readonly, assign) TBTimerStatus status;


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

/// 开始
- (void)start;
/// 重制倒计时
- (void)resetTime;
/// 暂停
- (void)suspend;
/// 恢复
- (void)resume;
/// 取消定时器
- (void)cancel;
/// 重制定时器
- (void)resetTimer;

/// 添加、删除回调对象
- (void)addDelegate:(id <TBTimerEventDelegate> _Nullable) delegate;
- (void)removeDelegate:(id <TBTimerEventDelegate> _Nullable) delegate;




@end

