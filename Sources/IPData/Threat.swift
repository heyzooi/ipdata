import Foundation

public struct Threat: Decodable {
    
    public let isTor: Bool
    public let isProxy: Bool
    public let isAnonymous: Bool
    public let isKnownAttacker: Bool
    public let isKnownAbuser: Bool
    public let isThreat: Bool
    public let isBogon: Bool
    
    public enum CodingKeys: String, CodingKey {
        
        case isTor = "is_tor"
        case isProxy = "is_proxy"
        case isAnonymous = "is_anonymous"
        case isKnownAttacker = "is_known_attacker"
        case isKnownAbuser = "is_known_abuser"
        case isThreat = "is_threat"
        case isBogon = "is_bogon"
        
    }
    
}
