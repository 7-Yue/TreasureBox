import XCTest
@testable import TreasureBox

final class TreasureBoxTests: XCTestCase {

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
        class A {
            init() {
                
            }
        }    
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension TreasureBoxTests {
    func testOCAssociatedObject() throws {
        let a = UIView(frame: .zero)
        do {
            a.setAssociatedValue(1, key: "age", policy: .assign)
            print(a.getAssociatedValue(withKey: "age") ?? "")
        }
        
        do {
            let str = NSMutableString(string: "123")
            a.setAssociatedValue(str, key: "str", policy: .retain)
            str.append("333")
            print(a.getAssociatedValue(withKey: "str") ?? "")
        }
        
        do {
            class Info {
                var math: Int
                var english: Int
                init(math: Int = 80, english: Int = 70) {
                    self.math = math
                    self.english = english
                }
            }
            var info: Info? = Info()
            a.setAssociatedValue(info, key: "info", policy: .weak)
            info = nil
            print(a.getAssociatedValue(withKey: "info") ?? "")
        }
        
        do {
            let text = NSMutableString(string: "123")
            a.setAssociatedValue(text, key: "text", policy: .copy)
            text.append("333")
            print(a.getAssociatedValue(withKey: "text") ?? "")
        }
    }
}
