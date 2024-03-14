import Foundation

// MARK: - Userdefaults 的属性包装器

@propertyWrapper
public class UserSettingsOpt<T> {
    let suiteName: String?
    let key: String
    var memoryValue: T?
    
    public var wrappedValue: T? {
        set {
            self.save(value: newValue)
        }
        get {
            return self.memoryValue
        }
    }
    
    public init(suiteName: String? = nil, key: String, initialValue: T? = nil) {
        self.suiteName = suiteName
        self.key = key
        self.fetch()
        self.memoryValue = self.memoryValue ?? initialValue
    }
    
    private func save(value:T?) {
        let setting = UserDefaults(suiteName: self.suiteName) ?? UserDefaults.standard
        switch T.self {
        case is Int.Type:           setting.set(value as? Int, forKey: self.key)
        case is Float.Type:         setting.set(value as? Float, forKey: self.key)
        case is Double.Type:        setting.set(value as? Double, forKey: self.key)
        case is Bool.Type:          setting.set(value as? Bool, forKey: self.key)
        case is URL.Type:           setting.set(value as? URL, forKey: self.key)
        case is String.Type:        setting.set(value as? String, forKey: self.key)
        case is Data.Type:          setting.set(value as? Data, forKey: self.key)
        case is [String].Type:      setting.set(value as? [String], forKey: self.key)
        case is [String:Any].Type:  setting.set(value as? [String:Any], forKey: self.key)
        case is [Any].Type:         setting.set(value as? [Any], forKey: self.key)
        case is NSData.Type:        setting.set(value as? NSData, forKey: self.key)
        case is NSDictionary.Type:  setting.set(value as? NSDictionary, forKey: self.key)
        case is NSNumber.Type:      setting.set(value as? NSNumber, forKey: self.key)
        case is NSDate.Type:        setting.set(value as? NSDate, forKey: self.key)
        case is NSString.Type:      setting.set(value as? NSString, forKey: self.key)
        case is NSArray.Type:       setting.set(value as? NSArray, forKey: self.key)
        case is NSDictionary.Type:  setting.set(value as? NSDictionary, forKey: self.key)
        default:                    assert(true, "存储错误的数据类型")
        }
        self.memoryValue = value
    }
    
    private func fetch() {
        let setting = UserDefaults(suiteName: self.suiteName) ?? UserDefaults.standard
        if setting.dictionaryRepresentation().keys.contains(self.key) {
            switch T.self {
            case is Int.Type:           self.memoryValue = setting.integer(forKey: self.key) as? T
            case is Float.Type:         self.memoryValue = setting.float(forKey: self.key) as? T
            case is Double.Type:        self.memoryValue = setting.double(forKey: self.key) as? T
            case is Bool.Type:          self.memoryValue = setting.bool(forKey: self.key) as? T
            case is URL.Type:           self.memoryValue = setting.url(forKey: self.key) as? T
            case is String.Type:        self.memoryValue = setting.string(forKey: self.key) as? T
            case is Data.Type:          self.memoryValue = setting.data(forKey: self.key) as? T
            case is [String].Type:      self.memoryValue = setting.stringArray(forKey: self.key) as? T
            case is [String:Any].Type:  self.memoryValue = setting.dictionary(forKey: self.key) as? T
            case is [Any].Type:         self.memoryValue = setting.array(forKey: self.key) as? T
            default:                    assert(true, "存储错误的数据类型")
            }
        }
    }
}

@propertyWrapper
public class UserSettings<T> {
    let suiteName: String?
    let key: String
    let defaultValue: T
    var memoryValue: T
    
    public var wrappedValue: T {
        set {
            self.save(value: newValue)
        }
        get {
            return self.memoryValue
        }
    }
    
    public init(suiteName: String? = nil, key: String, defaultValue: T) {
        self.suiteName = suiteName
        self.key = key
        self.defaultValue = defaultValue
        
        let setting = UserDefaults(suiteName: self.suiteName) ?? UserDefaults.standard
        var temp: Any? = nil
        if setting.dictionaryRepresentation().keys.contains(self.key) {
            switch T.self {
            case is Int.Type:           temp = setting.integer(forKey: self.key) as? T
            case is Float.Type:         temp = setting.float(forKey: self.key) as? T
            case is Double.Type:        temp = setting.double(forKey: self.key) as? T
            case is Bool.Type:          temp = setting.bool(forKey: self.key) as? T
            case is URL.Type:           temp = setting.url(forKey: self.key) as? T
            case is String.Type:        temp = setting.string(forKey: self.key) as? T
            case is Data.Type:          temp = setting.data(forKey: self.key) as? T
            case is [String].Type:      temp = setting.stringArray(forKey: self.key) as? T
            case is [String:Any].Type:  temp = setting.dictionary(forKey: self.key) as? T
            case is [Any].Type:         temp = setting.array(forKey: self.key) as? T
            default:                    assert(true, "存储错误的数据类型")
            }
        }
        self.memoryValue = (temp as? T) ?? self.defaultValue
    }
    
    private func save(value:T?) {
        let setting = UserDefaults(suiteName: self.suiteName) ?? UserDefaults.standard
        switch T.self {
        case is Int.Type:           setting.set(value as? Int, forKey: self.key)
        case is Float.Type:         setting.set(value as? Float, forKey: self.key)
        case is Double.Type:        setting.set(value as? Double, forKey: self.key)
        case is Bool.Type:          setting.set(value as? Bool, forKey: self.key)
        case is URL.Type:           setting.set(value as? URL, forKey: self.key)
        case is String.Type:        setting.set(value as? String, forKey: self.key)
        case is Data.Type:          setting.set(value as? Data, forKey: self.key)
        case is [String].Type:      setting.set(value as? [String], forKey: self.key)
        case is [String:Any].Type:  setting.set(value as? [String:Any], forKey: self.key)
        case is [Any].Type:         setting.set(value as? [Any], forKey: self.key)
        case is NSData.Type:        setting.set(value as? NSData, forKey: self.key)
        case is NSDictionary.Type:  setting.set(value as? NSDictionary, forKey: self.key)
        case is NSNumber.Type:      setting.set(value as? NSNumber, forKey: self.key)
        case is NSDate.Type:        setting.set(value as? NSDate, forKey: self.key)
        case is NSString.Type:      setting.set(value as? NSString, forKey: self.key)
        case is NSArray.Type:       setting.set(value as? NSArray, forKey: self.key)
        case is NSDictionary.Type:  setting.set(value as? NSDictionary, forKey: self.key)
        default:                    assert(true, "存储错误的数据类型")
        }
        self.memoryValue = value ?? self.defaultValue
    }
}

