import Foundation

public struct Timezone: Decodable {
    
    public let name: String
    public let abbr: String
    public let offset: String
    public let isDST: Bool
    public let currentTime: String
    
    public enum CodingKeys: String, CodingKey {
        
        case name
        case abbr
        case offset
        case isDST = "is_dst"
        case currentTime = "current_time"
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        abbr = try container.decode(String.self, forKey: .abbr)
        offset = try container.decode(String.self, forKey: .offset)
        isDST = (try? container.decode(Bool.self, forKey: .isDST)) ?? false
        currentTime = try container.decode(String.self, forKey: .currentTime)
    }
    
}
