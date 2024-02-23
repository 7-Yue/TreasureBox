import Foundation

// MARK: - DataStructureTool

public func isNSObjectType(_ v: Any) -> Bool {
    print(v)
    return v is NSObject || v is NSObject.Type
}

public func getProperty(_ v: Any) -> [String] {
    var list = [String]()
    if v is NSObject {
        var propertiesCount : CUnsignedInt = 0
        let properties = class_copyPropertyList(type(of: v) as? AnyClass, &propertiesCount)
        for i in 0 ..< Int(propertiesCount) {
            if let property = properties?[i] {
                let name = String(cString: property_getName(property))
                list.append(name)
            }
        }
    } else if v is NSObject.Type {
        var propertiesCount : CUnsignedInt = 0
        let properties = class_copyPropertyList(v as? AnyClass, &propertiesCount)
        for i in 0 ..< Int(propertiesCount) {
            if let property = properties?[i] {
                let name = String(cString: property_getName(property))
                list.append(name)
            }
        }
    } else {
        let mirror = Mirror(reflecting: v)
        mirror.children.forEach { (label, value) in
            if let `label` = label {
                list.append(label)
            }
        }
    }
    return list
}
