import XCTest
@testable import TreasureBox

final class TBTimerTests: XCTestCase {

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

var v = 61

extension TBTimerTests {

    func testTimer() throws {
        let expectation = XCTestExpectation(description: "异步结束")
        
        class ContainerBox: NSObject, TBTimerEventDelegate {
            func timerEvent(with timer: TBTimer) {
                v = v - 1
                print(v)
                if (v == 55) {
                    timer.suspend()
                }
            }
        }
        print("start")
        let box = ContainerBox()
        let timer = TBTimer(timeInterval: 1.0, delayInterval: 0.0, dispatchQueue: DispatchQueue.main, isRepeat: true)
        timer.add(box)
        timer.resume()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(6)) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 6)
    }
}
