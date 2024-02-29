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
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension TreasureBoxTests {
    
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
    
    func testAssociatedProperty() throws {
        class Obj {
            let p1 = "123"
            let p2 = "12"
            let p3 = "1"
            init() {
                
            }
        }
        
        class SwiftPerson {
            var name: String
            var age: Int
            var o1: Obj?
            var o2: Obj?
            init(name: String, age: Int, o1: Obj? = nil, o2: Obj? = nil) {
                self.name = name
                self.age = age
                self.o1 = o1
                self.o2 = o2
            }
        }
        
        class OCPerson: NSObject {
            var name: String
            var age: Int
            var o1: Obj?
            var o2: Obj?
            init(name: String, age: Int, o1: Obj? = nil, o2: Obj? = nil) {
                self.name = name
                self.age = age
                self.o1 = o1
                self.o2 = o2
            }
        }
        
        let c1 = SwiftPerson(name: "c1", age: 2, o1: Obj(), o2: Obj())
        
        //  assign
        var c1AssociatedValue1 = UnsafeRawPointer(("c1AssociatedValue" as NSString).utf8String)
        let c1AssociatedValue1_exp = expectation(description: "c1AssociatedValue1_exp")
        setAssociated(object: c1, key: &c1AssociatedValue1, value: 3, policy: .assign)
        DispatchQueue.global().async {
            if let v = getAssociated(object: c1, key: &c1AssociatedValue1) {
                c1AssociatedValue1_exp.fulfill()
            }
        }
        
        //  weak
        var c1AssociatedValue2 = UnsafeRawPointer(("c1AssociatedValue2" as NSString).utf8String)
        var c1AssociatedValue2_value: Obj? = Obj()
        
        let c1AssociatedValue2_exp1 = expectation(description: "c1AssociatedValue2_exp1")
        setAssociated(object: c1, key: &c1AssociatedValue2, value: c1AssociatedValue2_value, policy: .weak)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if let _ = getAssociated(object: c1, key: &c1AssociatedValue2) {
                c1AssociatedValue2_exp1.fulfill()
            }
        }
        
        let c1AssociatedValue2_exp2 = expectation(description: "c1AssociatedValue2_exp2")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            c1AssociatedValue2_value = nil
            guard let _ = getAssociated(object: c1, key: &c1AssociatedValue2) else {
                c1AssociatedValue2_exp2.fulfill()
                return
            }
        }
        
        // nonatomic_copy
        var c1AssociatedValue3 = UnsafeRawPointer(("c1AssociatedValue3" as NSString).utf8String)
        let c1AssociatedValue3_value: NSMutableArray? = NSMutableArray()
        
        let c1AssociatedValue3_exp = expectation(description: "c1AssociatedValue3_exp")
        setAssociated(object: c1, key: &c1AssociatedValue3, value: c1AssociatedValue3_value, policy: .nonatomic_copy)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if let _ = getAssociated(object: c1, key: &c1AssociatedValue3) as? NSArray {
                c1AssociatedValue3_exp.fulfill()
            }
        }
        
        // nonatomic_retain
        var c1AssociatedValue4 = UnsafeRawPointer(("c1AssociatedValue4" as NSString).utf8String)
        let c1AssociatedValue4_value: NSMutableArray? = NSMutableArray()
        
        let c1AssociatedValue4_exp = expectation(description: "c1AssociatedValue4_exp")
        setAssociated(object: c1, key: &c1AssociatedValue4, value: c1AssociatedValue4_value, policy: .nonatomic_retain)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if let v = getAssociated(object: c1, key: &c1AssociatedValue4) as? NSMutableArray {
                v.add("1")
            }
            if let v = getAssociated(object: c1, key: &c1AssociatedValue4) as? NSMutableArray, v.count > 0 {
                c1AssociatedValue4_exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
}
