#import <XCTest/XCTest.h>
#import <TreasureBox/NSMethodSignature+TBExtension.h>

@interface TestDemo : NSObject

@end

@implementation TestDemo

- (NSString *)helloWithS:(NSString *) s i:(NSInteger) i sel:(SEL) sel {
    return @"123";
}

@end

@interface NSMethodSignatureTBExtensionTests : XCTestCase

@end

@implementation NSMethodSignatureTBExtensionTests

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

- (void)testNSMethodSignatureCType {
    NSString * str = [[TestDemo new] methodSignatureForSelector:@selector(helloWithS:i:sel:)].ctype;;
    NSLog(@"%@", str);
}

@end
