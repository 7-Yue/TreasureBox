#import "NSMethodSignature+TBExtension.h"

@implementation NSMethodSignature (TBExtension)

- (NSString * _Nonnull)ctype {
    NSMutableString *str = [NSMutableString string];
    
    const char *returnType = [self methodReturnType];
    NSString *returnTypeString = [NSString stringWithUTF8String:returnType];
    
    [str appendString:returnTypeString];
    
    for (int i = 0; i < [self numberOfArguments]; i++) {
        const char *argumentType = [self getArgumentTypeAtIndex:i];
        NSString *argumentTypeString = [NSString stringWithUTF8String:argumentType];

        [str appendString:argumentTypeString];
    }
    
    return [str copy];
}

@end
