import Foundation

public struct Currency: Decodable {
    
    public let name: String
    public let code: String
    public let symbol: String
    public let native: String
    public let plural: String
    
}
