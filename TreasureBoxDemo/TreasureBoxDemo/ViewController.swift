import UIKit
import TreasureBox

class ViewController: UIViewController {
    
    
    var t:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let btn = UIButton(frame: CGRect(x: 50, y: 200, width: 100, height: 40))
        btn.setTitle("vc", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(ViewController.routeVC), for: .touchUpInside)
        self.view.addSubview(btn)
        
        self.t = Timer.tb_scheduledTimer(withTimeInterval: 1.0, weakTarget: self, selector: #selector(ac), userInfo: nil, repeats: true)
    }
    
    @objc func routeVC() {
        let vc = DEMOVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func ac() {
        print("时间计数器:\(NSDate())")
    }
}


class DEMOVC : UIViewController, TBTimerEventDelegate {
    func timerEvent(with timer: TBTimer) {
        print(v)
        v = v - 5
    }
    
    var v = 60
    
    let timer = TBTimer(timeInterval: 5.0, delayInterval: 0.0, dispatchQueue: DispatchQueue.main, isRepeat: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.timer.add(self)
        
        let btn1 = UIButton(frame: CGRect(x: 50, y: 200, width: 100, height: 40))
        btn1.setTitle("start", for: .normal)
        btn1.setTitleColor(.red, for: .normal)
        btn1.addTarget(self, action: #selector(start), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 50, y: 240, width: 100, height: 40))
        btn2.setTitle("resetTime", for: .normal)
        btn2.setTitleColor(.red, for: .normal)
        btn2.addTarget(self, action: #selector(resetTime), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn3 = UIButton(frame: CGRect(x: 50, y: 280, width: 100, height: 40))
        btn3.setTitle("resume", for: .normal)
        btn3.setTitleColor(.red, for: .normal)
        btn3.addTarget(self, action: #selector(resume), for: .touchUpInside)
        self.view.addSubview(btn3)
        
        let btn4 = UIButton(frame: CGRect(x: 50, y: 320, width: 100, height: 40))
        btn4.setTitle("suspend", for: .normal)
        btn4.setTitleColor(.red, for: .normal)
        btn4.addTarget(self, action: #selector(suspend), for: .touchUpInside)
        self.view.addSubview(btn4)
        
        let btn5 = UIButton(frame: CGRect(x: 50, y: 360, width: 100, height: 40))
        btn5.setTitle("cancel", for: .normal)
        btn5.setTitleColor(.red, for: .normal)
        btn5.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.view.addSubview(btn5)
        
        let btn6 = UIButton(frame: CGRect(x: 50, y: 400, width: 100, height: 40))
        btn6.setTitle("resetTimer", for: .normal)
        btn6.setTitleColor(.red, for: .normal)
        btn6.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        self.view.addSubview(btn6)
        
        let btn7 = UIButton(frame: CGRect(x: 50, y: 440, width: 100, height: 40))
        btn7.setTitle("back", for: .normal)
        btn7.setTitleColor(.red, for: .normal)
        btn7.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(btn7)
    }
    
    @objc func start() {
        self.timer.start()
    }
    
    @objc func resetTime() {
        self.timer.resetTime()
    }
    
    @objc func resume() {
        self.timer.resume()
    }
    
    @objc func suspend() {
        self.timer.suspend()
    }
    
    @objc func cancel() {
        self.timer.cancel()
    }
    
    @objc func resetTimer() {
        self.timer.resetTimer()
        self.v = 60
    }
    
    @objc func back() {
        self.dismiss(animated: true)
    }
}
