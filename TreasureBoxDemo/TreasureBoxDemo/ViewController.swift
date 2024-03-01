import UIKit
import TreasureBox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        class A {
            let x = 3
        }
        var a = A()
        var t = 3
        QueryAnythingAddresss(&t)
        QueryAnythingAddresss(&t)
        withUnsafePointer(to: &t) {
            print("The address of someVariable is: \($0)")
        }
        withUnsafePointer(to: t) {
            print("The address of someVariable is: \($0)")
        }
        print("2")
    }


}

