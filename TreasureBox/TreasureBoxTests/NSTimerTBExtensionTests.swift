import XCTest
@testable import TreasureBox

final class NSTimerTBExtensionTests: XCTestCase {

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

extension NSTimerTBExtensionTests {
    func testTimer() throws {
        class Box {
            var timer: Timer?
            init() {
                self.timer = Timer.tb_scheduledTimer(withTimeInterval: 1.0,
                                                     weakTarget: self,
                                                     selector: #selector(Box.log),
                                                     userInfo: nil,
                                                     repeats: true)
//                self.timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                                  target: self,
//                                                  selector: #selector(Box.log),
//                                                  userInfo: nil,
//                                                  repeats: true)
            }
            
            deinit {
                let t = self.timer!
                self.timer?.invalidate()
                print("释放Box")
                
                let runloop = CFRunLoopGetCurrent()
                let isContain = CFRunLoopContainsTimer(runloop, t, CFRunLoopMode.defaultMode)
                print("是否包含: \(isContain)")
            }
            
            @objc
            func log() {
                print(1)
            }
        }
        var box: Box? = Box()
        let runloop = CFRunLoopGetCurrent()
        let isContain = CFRunLoopContainsTimer(runloop, box!.timer!, CFRunLoopMode.defaultMode)
        print("是否包含: \(isContain)")
        let expectation = XCTestExpectation(description: "异步结束")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            box = nil
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(7)) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 8)
    }
}
