import UIKit
import TreasureBox

class Demo {
    @objc func t() {
        print(123)
    }
}

class ViewController: UIViewController {
    
    var timer: Timer?
    var demo: Demo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.demo = Demo()
        self.timer = Timer.tb_scheduledTimer(withTimeInterval: 1.0, weakTarget: self.demo, selector: #selector(Demo.t), userInfo: nil, repeats: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.demo = nil
    }
}

