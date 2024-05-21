#import <XCTest/XCTest.h>
#import <TreasureBox/NSObject+TBExtension.h>

@interface Person : NSObject


@end

@implementation Person

+ (void)load {
    SwizzleMethod([self class],
                  @selector(f0),
                  @selector(f1),
                  NO);
}

- (void)f1 {
    NSLog(@"本来是f1，现在是%@", NSStringFromSelector(_cmd));
}

@end

@interface Boy : Person


@end

@implementation Boy

+ (void)load {
    SwizzleMethod([self class],
                  @selector(f1),
                  @selector(f2),
                  NO);
}

- (void)f2 {
    NSLog(@"本来是f2，现在是%@", NSStringFromSelector(_cmd));
}

@end

@interface NSObjectTBExtensionTests : XCTestCase

@end

@implementation NSObjectTBExtensionTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSwizzleMethod {
    [[Person new] performSelector:@selector(f0)];
    [[Person new] f1];
    NSLog(@"~~~~~~~~~");
    [[Boy new] f1];
    [[Boy new] f2];
}
@end
