import UIKit
import TreasureBox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let p = Bundle.main.path(forResource: "image", ofType: "png") ?? ""
        // 调用示例
        let fileURL = URL(fileURLWithPath: p)
        hexDump(fileURL: fileURL)
    }
    
    func hexDump(fileURL: URL) {
        do {
            // 读取文件数据
            let data = try Data(contentsOf: fileURL)
            
            // 将数据转换为十六进制字符串
            let hexStrings = data.map { String(format: "%02hhx", $0) }
            
            // 每行显示16个字节
            let chunkSize = 16
            for chunkIndex in stride(from: 0, to: hexStrings.count, by: chunkSize) {
                let chunk = Array(hexStrings[chunkIndex..<min(chunkIndex + chunkSize, hexStrings.count)])
                let line = chunk.joined(separator: " ")
                print(line)
            }
        } catch {
            print("Failed to read file:", error)
        }
    }


}

