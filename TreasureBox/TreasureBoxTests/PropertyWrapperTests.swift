import XCTest
@testable import TreasureBox

final class PropertyWrapperToolTests: XCTestCase {

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

extension PropertyWrapperToolTests {
    
    func testUserSettings() throws {
        class N {
            var n:String
            init(n: String) {
                self.n = n
            }
        }
        
        class M {
            @UserSettings(suiteName: "a", key: "x",defaultValue: 2)
            var x: Int
            @UserSettings(suiteName: "a", key: "y",defaultValue: 0.5)
            var y: Float
            @UserSettings(suiteName: "a", key: "z",defaultValue: 0.1)
            var z: Double
            @UserSettings(suiteName: "a", key: "q",defaultValue: false)
            var q: Bool
            @UserSettings(suiteName: "a", key: "p",defaultValue: URL(string: "https://www.baidu.com")!)
            var p: URL
            @UserSettings(suiteName: "a", key: "s",defaultValue: "a")
            var s: String
            @UserSettings(suiteName: "a", key: "d",defaultValue: "1".data(using: .utf8)!)
            var d: Data
            @UserSettings(suiteName: "a", key: "b",defaultValue: ["a"])
            var b: [String]
            @UserSettings(suiteName: "a", key: "c",defaultValue: ["age": 1])
            var c: [String: Int]
            @UserSettings(suiteName: "a", key: "l",defaultValue: [N(n: "h")])
            var l: [N]
            @UserSettings(suiteName: "a", key: "a",defaultValue: ["c": N(n: "h")])
            var a: [String: N]
            @UserSettings(suiteName: "a", key: "t",defaultValue: Date())
            var t: Date
        }

        let m = M()
        print(m.x);m.x = 3;print(m.x);m.x = 4;print(m.x)
        print(m.y);m.y = 0.6;print(m.y);m.y = 0.7;print(m.y)
        print(m.z);m.z = 0.2;print(m.z);m.z = 0.3;print(m.z)
        print(m.q);m.q = true;print(m.q);m.q = false;print(m.q)
        print(m.p);m.p = URL(string: "https://www.qq.com")!;print(m.p);m.p = URL(string: "https://www.wuyu.com")!;print(m.p)
        print(m.s);m.s = "b";print(m.s);m.s = "c";print(m.s)
        print(m.d);m.d = "2".data(using: .utf8)!;print(m.d);m.d = "3".data(using: .utf8)!;print(m.d)
        print(m.b);m.b = ["b"];print(m.b);m.b = ["c"];print(m.b)
        print(m.c);m.c = ["age": 2];print(m.c);m.c = ["age": 3];print(m.c)
        print(m.l);m.l = [N(n: "h"),N(n: "o")];print(m.l);m.l = [N(n: "x"),N(n: "w")];print(m.l)
        print(m.a);m.a = ["c": N(n: "a")];print(m.a);m.a = ["c": N(n: "q")];print(m.a)
        print(m.t);m.t = Date(timeIntervalSinceNow: 3000);print(m.t);m.t = Date(timeIntervalSinceNow: 300);print(m.t)
         
    }
    
}
