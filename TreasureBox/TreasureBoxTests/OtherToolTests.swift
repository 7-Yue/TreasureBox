import XCTest
@testable import TreasureBox

final class OtherToolTests: XCTestCase {

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

protocol C {
    var c: Int { get set }
}

extension OtherToolTests {
    func testAnythingName() throws {
        class A {
            let a:Int
            init(a: Int) {
                self.a = a
            }
        }
        
        struct B {
            let b: Int
            init(b: Int) {
                self.b = b
            }
        }
        
        struct C1 : C {
            var c: Int
            
            init(c: Int) {
                self.c = c
            }
        }
        
        print(TreasureBox.name(A.self))
        print(TreasureBox.name(A(a: 1)))
        print(TreasureBox.name(B.self))
        print(TreasureBox.name(B(b: 1)))
        print(TreasureBox.name(C.self))
        print(TreasureBox.name(C1.self))
        print(TreasureBox.name(C1(c: 3)))
        print(TreasureBox.name(""))
        print(TreasureBox.name(NSObject()))
        print(TreasureBox.name(NSObject.self))
    }
    
    func testDataHex() throws {
        let value: Int = 42
        var data = Data()
        withUnsafeBytes(of: value) { ptr in
            data.append(contentsOf: ptr)
        }
        print(dataHex(data))
    }
}
