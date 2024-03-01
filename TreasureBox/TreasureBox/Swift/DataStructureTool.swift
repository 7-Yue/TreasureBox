import Foundation

// MARK: - Judge NSObject Type

public func isNSObjectType(_ v: Any) -> Bool {
    print(v)
    return v is NSObject || v is NSObject.Type
}

// MARK: - Get Property

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
    } else if v is NSObject.Type {// 元类型判断
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

// MARK: - Associated Property

public enum AssociationPolicy {
    case assign
    case weak
    case atomic_copy
    case atomic_retain
    case nonatomic_copy
    case nonatomic_retain
}

public func setAssociated(object: Any, key: UnsafeRawPointer, value: Any?, policy: AssociationPolicy) {
    switch policy {
    case .assign:
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_ASSIGN)
    case .weak:
        if let c = value as? AnyObject {
            let closure: () -> Any? = { [weak c] in
                return c
            }
            objc_setAssociatedObject(object, key, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    case .atomic_copy:
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_COPY)
    
    case .atomic_retain:
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN)
    
    case .nonatomic_copy:
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    
    case .nonatomic_retain:
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    
    }
}

public func getAssociated(object: Any, key: UnsafeRawPointer) -> Any? {
    let value = objc_getAssociatedObject(object, key)
    if let c = value as? (() -> Any?) {
        return c()
    }
    return value
}
