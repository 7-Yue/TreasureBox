import XCTest
@testable import TreasureBox

final class DataStructureToolTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension DataStructureToolTests {
    func testIsNSObjectType() throws {
        XCTAssert(isNSObjectType(UIView.self), "UIView.self 应该属于 NSObject类型")
        XCTAssert(isNSObjectType(UIView()), "UIView() 应该属于 NSObject类型")
        class X { init() { } }
        XCTAssert(!isNSObjectType(X()), "X() 不应该属于 NSObject类型")
        XCTAssert(!isNSObjectType(X.self), "X.self 不应该属于 NSObject类型")
    }
    
    func testGetProperty() throws {
        XCTAssert(getProperty(UIView()).count > 0, "没有获取到UIView()的属性列表")
        XCTAssert(getProperty(UIView.self).count > 0, "没有获取到UIView.self的属性列表")
        class X { let a = 5; init() { } }
        XCTAssert(getProperty(X()).count > 0, "没有获取到X()的属性列表")
        XCTAssert(getProperty(X.self).count <= 0, "不应该获取到X.self的属性列表")
    }
}
