import Foundation

public func isNSObjectType(_ v: Any) -> Bool {
    return v is NSObject || v is NSObject.Type
}
