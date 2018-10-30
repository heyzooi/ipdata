import Foundation

public struct IP: Decodable {
    
    public let ip: String
    public let isEU: Bool
    public let count: String
    public let city: String
    public let region: String
    public let regionCode: String
    public let countryName: String
    public let countryCode: String
    public let continentName: String
    public let continentCode: String
    public let latitude: Double
    public let longitude: Double
    public let asn: String
    public let organisation: String
    public let postal: String
    public let callingCode: String
    public let flag: String
    public let emojiFlag: String
    public let emojiUnicode: String
    public let carrier: Carrier?
    public let languages: [Language]
    public let currency: Currency
    public let timezone: Timezone
    public let threat: Threat
    
    public enum CodingKeys: String, CodingKey {
        
        case ip
        case isEU = "is_eu"
        case count
        case city
        case region
        case regionCode = "region_code"
        case countryName = "country_name"
        case countryCode = "country_code"
        case continentName = "continent_name"
        case continentCode = "continent_code"
        case latitude
        case longitude
        case asn
        case organisation
        case postal
        case callingCode = "calling_code"
        case flag
        case emojiFlag = "emoji_flag"
        case emojiUnicode = "emoji_unicode"
        case carrier
        case languages
        case currency
        case timezone = "time_zone"
        case threat
        
    }
    
}
