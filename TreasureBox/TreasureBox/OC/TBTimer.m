#import "TBTimer.h"

@interface TBTimer()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSHashTable *delegatesTable;
@property (nonatomic, assign) BOOL didUnrepeatTask;
@property (nonatomic, readwrite, assign) BOOL isRepeat;
@property (nonatomic, readwrite, assign) NSTimeInterval timeInterval;
@property (nonatomic, readwrite, assign) NSTimeInterval delayInterval;
@property (nonatomic, readwrite, assign) TBTimerStatus status;
@end

@implementation TBTimer

- (instancetype _Nonnull)initWithTimeInterval:(NSTimeInterval) timeInterval
                                delayInterval:(NSTimeInterval) delayInterval
                                dispatchQueue:(dispatch_queue_t _Nonnull) queue
                                     isRepeat:(BOOL) isRepeat {
    self = [super init];
    if (self) {
        self.queue = queue;
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
        self.isRepeat = isRepeat;
        self.timeInterval = timeInterval;
        self.delayInterval = delayInterval;
        self.didUnrepeatTask = NO;
        self.status = TBTimerStatus_Prepare;
        
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(self.timer, ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (!strongSelf.isRepeat && strongSelf.didUnrepeatTask) {
                if (dispatch_source_testcancel(strongSelf.timer) == 0) {
                    dispatch_source_cancel(strongSelf.timer);
                }
                strongSelf.status = TBTimerStatus_End;
                return;
            }
            [strongSelf.delegatesTable.allObjects enumerateObjectsUsingBlock:^(id<TBTimerEventDelegate>  _Nonnull obj,
                                                                               NSUInteger idx,
                                                                               BOOL * _Nonnull stop) {
                if (obj && [obj respondsToSelector:@selector(timerEventWithTimer:)]) {
                    [obj timerEventWithTimer:weakSelf];
                }
            }];
            strongSelf.didUnrepeatTask = YES;
        });
    }
    return self;
}

- (void)dealloc {
    switch (self.status) {
        case TBTimerStatus_Prepare:
            dispatch_resume(self.timer);
            if (dispatch_source_testcancel(self.timer) == 0) {
                dispatch_source_cancel(self.timer);
            }
            break;
        case TBTimerStatus_Working:
            if (dispatch_source_testcancel(self.timer) == 0) {
                dispatch_source_cancel(self.timer);
            }
            break;
        case TBTimerStatus_Suspend:
            dispatch_resume(self.timer);
            if (dispatch_source_testcancel(self.timer) == 0) {
                dispatch_source_cancel(self.timer);
            }
            break;
        case TBTimerStatus_End:
            break;
    }
}

- (void)start {
    switch (self.status) {
        case TBTimerStatus_Prepare:
            dispatch_source_set_timer(self.timer,
                                      dispatch_time(DISPATCH_TIME_NOW, self.delayInterval * NSEC_PER_SEC),
                                      self.timeInterval * NSEC_PER_SEC,
                                      0 * NSEC_PER_SEC);
            dispatch_activate(self.timer);
            self.status = TBTimerStatus_Working;
            break;
        case TBTimerStatus_Working:

            break;
        case TBTimerStatus_Suspend:

            break;
        case TBTimerStatus_End:
            
            break;
    }
}

- (void)resetTime {
    switch (self.status) {
        case TBTimerStatus_Prepare:
            break;
        case TBTimerStatus_Working:
            dispatch_source_set_timer(self.timer,
                                      dispatch_time(DISPATCH_TIME_NOW, self.delayInterval * NSEC_PER_SEC),
                                      self.timeInterval * NSEC_PER_SEC,
                                      0 * NSEC_PER_SEC);
            break;
        case TBTimerStatus_Suspend:
            dispatch_source_set_timer(self.timer,
                                      dispatch_time(DISPATCH_TIME_NOW, self.delayInterval * NSEC_PER_SEC),
                                      self.timeInterval * NSEC_PER_SEC,
                                      0 * NSEC_PER_SEC);
            break;
        case TBTimerStatus_End:
            
            break;
    }
}

- (void)suspend {
    switch (self.status) {
        case TBTimerStatus_Prepare:

            break;
        case TBTimerStatus_Working:
            dispatch_suspend(self.timer);
            self.status = TBTimerStatus_Suspend;
            break;
        case TBTimerStatus_Suspend:

            break;
        case TBTimerStatus_End:
            
            break;
    }
}

- (void)resume {
    switch (self.status) {
        case TBTimerStatus_Prepare:

            break;
        case TBTimerStatus_Working:

            break;
        case TBTimerStatus_Suspend:
            dispatch_resume(self.timer);
            self.status = TBTimerStatus_Working;
            break;
        case TBTimerStatus_End:
            
            break;
    }
}

- (void)cancel {
    switch (self.status) {
        case TBTimerStatus_Prepare:

            break;
        case TBTimerStatus_Working:
            dispatch_source_cancel(self.timer);
            self.status = TBTimerStatus_End;
            break;
        case TBTimerStatus_Suspend:
            dispatch_resume(self.timer);
            dispatch_source_cancel(self.timer);
            self.status = TBTimerStatus_End;
            break;
        case TBTimerStatus_End:
            
            break;
    }
}

- (void)resetTimer {
    switch (self.status) {
        case TBTimerStatus_Prepare:
            dispatch_resume(self.timer);
            if (dispatch_source_testcancel(self.timer) == 0) {
                dispatch_source_cancel(self.timer);
            }
            break;
        case TBTimerStatus_Working:
            if (dispatch_source_testcancel(self.timer) == 0) {
                dispatch_source_cancel(self.timer);
            }
            break;
        case TBTimerStatus_Suspend:
            dispatch_resume(self.timer);
            if (dispatch_source_testcancel(self.timer) == 0) {
                dispatch_source_cancel(self.timer);
            }
            break;
        case TBTimerStatus_End:
            break;
    }
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    self.didUnrepeatTask = NO;
    self.status = TBTimerStatus_Prepare;
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf.isRepeat && strongSelf.didUnrepeatTask) {
            if (dispatch_source_testcancel(strongSelf.timer) == 0) {
                dispatch_source_cancel(strongSelf.timer);
            }
            strongSelf.status = TBTimerStatus_End;
            return;
        }
        [strongSelf.delegatesTable.allObjects enumerateObjectsUsingBlock:^(id<TBTimerEventDelegate>  _Nonnull obj,
                                                                           NSUInteger idx,
                                                                           BOOL * _Nonnull stop) {
            if (obj && [obj respondsToSelector:@selector(timerEventWithTimer:)]) {
                [obj timerEventWithTimer:weakSelf];
            }
        }];
        strongSelf.didUnrepeatTask = YES;
    });
}

- (void)addDelegate:(id <TBTimerEventDelegate> _Nullable) delegate {
    if (!delegate) { return; }
    [self.delegatesTable addObject:delegate];
}

- (void)removeDelegate:(id <TBTimerEventDelegate> _Nullable) delegate {
    if (!delegate) { return; }
    [self.delegatesTable removeObject:delegate];
}

- (NSHashTable *)delegatesTable {
    if (!_delegatesTable) {
        _delegatesTable = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:1];
    }
    return _delegatesTable;
}

@end
