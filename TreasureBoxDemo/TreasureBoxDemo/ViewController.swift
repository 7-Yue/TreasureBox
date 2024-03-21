import UIKit
import TreasureBox

var v = 61

class ViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = DEMOVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


class DEMOVC : UIViewController, TBTimerEventDelegate {
    func timerEvent(with timer: TBTimer) {
        v = v - 1
        print(v)
        if (v == 55) {
            timer.finish()
        }
    }
    
    
    let timer = TBTimer(timeInterval: 1.0, delayInterval: 0.0, dispatchQueue: DispatchQueue.main, isRepeat: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.timer.add(self)
        self.timer.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.finish()
    }
    
    deinit {
        print("释放")
    }
}
