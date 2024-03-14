import Foundation

/// 获取唯一标识名
/// - Parameter o: 任何值，通过映射获取唯一值
/// - Returns: 唯一标识名
public func name(_ o: Any) -> String {
    return String(reflecting: o)
}

/// 获取Data数据的16进制值
/// - Parameter data: 二进制数据
/// - Returns: 16进制显示字符串
public func logDataHex(_ data: Data) -> String {
    // 将数据转换为十六进制字符串
    let hexStrings = data.map { String(format: "%02hhx", $0) }
    var res = ""
    // 每行显示16个字节
    let chunkSize = 16
    for chunkIndex in stride(from: 0, to: hexStrings.count, by: chunkSize) {
        let chunk = Array(hexStrings[chunkIndex..<min(chunkIndex + chunkSize, hexStrings.count)])
        let line = chunk.joined(separator: " ")
        print(line)
        res.append(line)
    }
    return res
}
