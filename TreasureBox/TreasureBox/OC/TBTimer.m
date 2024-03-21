#import "TBTimer.h"

@interface TBTimer()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) BOOL isSuspend;
@property (nonatomic, strong) NSHashTable *delegatesTable;
@property (nonatomic, assign) BOOL didFlag;
@property (nonatomic, readwrite, assign) BOOL isRepeat;
@property (nonatomic, readwrite, assign) NSTimeInterval timeInterval;
@property (nonatomic, readwrite, assign) NSTimeInterval delayInterval;

@end

@implementation TBTimer

- (instancetype _Nonnull)initWithTimeInterval:(NSTimeInterval) timeInterval
                                delayInterval:(NSTimeInterval) delayInterval
                                dispatchQueue:(dispatch_queue_t _Nonnull) queue
                                     isRepeat:(BOOL) isRepeat {
    self = [super init];
    if (self) {
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        self.isRepeat = isRepeat;
        self.timeInterval = timeInterval;
        self.delayInterval = delayInterval;
        self.didFlag = NO;
        self.isSuspend = YES;
        
        dispatch_source_set_timer(self.timer,
                                  dispatch_time(DISPATCH_TIME_NOW, self.delayInterval * NSEC_PER_SEC),
                                  self.timeInterval * NSEC_PER_SEC,
                                  0 * NSEC_PER_SEC);
        
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(self.timer, ^{
            if (!weakSelf) { return; }
            if (!weakSelf.isRepeat && weakSelf.didFlag) { return; }
            [weakSelf.delegatesTable.allObjects enumerateObjectsUsingBlock:^(id<TBTimerEventDelegate>  _Nonnull obj,
                                                                             NSUInteger idx,
                                                                             BOOL * _Nonnull stop) {
                if (obj && [obj respondsToSelector:@selector(timerEventWithTimer:)]) {
                    [obj timerEventWithTimer:weakSelf];
                }
            }];
            weakSelf.didFlag = YES;
        });
    }
    return self;
}

- (void)dealloc {
    if (self.isSuspend) {
        dispatch_resume(self.timer);
    }
    dispatch_source_cancel(self.timer);
}

- (void)addDelegate:(id <TBTimerEventDelegate> _Nullable) delegate {
    if (!delegate) { return; }
    [self.delegatesTable addObject:delegate];
}

- (void)removeDelegate:(id <TBTimerEventDelegate> _Nullable) delegate {
    if (!delegate) { return; }
    [self.delegatesTable removeObject:delegate];
}

- (void)resume {
    if (!self.isSuspend) { return; }
    self.didFlag = NO;
    dispatch_resume(self.timer);
    self.isSuspend = NO;
}

- (void)suspend {
    if (self.isSuspend) { return; }
    dispatch_suspend(self.timer);
    self.isSuspend = YES;
}

- (NSHashTable *)delegatesTable {
    if (!_delegatesTable) {
        _delegatesTable = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:1];
    }
    return _delegatesTable;
}

@end
