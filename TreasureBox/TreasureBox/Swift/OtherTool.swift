import Foundation

public func name(_ o: Any) -> String {
    return String(reflecting: o)
}

public func logDataHex(_ data: Data) {
    // 将数据转换为十六进制字符串
    let hexStrings = data.map { String(format: "%02hhx", $0) }
    
    // 每行显示16个字节
    let chunkSize = 16
    for chunkIndex in stride(from: 0, to: hexStrings.count, by: chunkSize) {
        let chunk = Array(hexStrings[chunkIndex..<min(chunkIndex + chunkSize, hexStrings.count)])
        let line = chunk.joined(separator: " ")
        print(line)
    }
}
