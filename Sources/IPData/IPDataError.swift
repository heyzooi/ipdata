import Foundation

public enum IPDataError {
    
    case invalidIP(message: String)
    case invalidAPIKey(message: String)
    case exceededLimit(message: String)
    case invalidResponse(statusCode: Int)
    case unknown
    
    init(statusCode: Int?, message: String? = nil) {
        switch (statusCode, message) {
        case (StatusCode.badRequest.rawValue, .some(let message)):
            self = .invalidIP(message: message)
        case (StatusCode.unauthorized.rawValue, .some(let message)):
            self = .invalidAPIKey(message: message)
        case (StatusCode.forbidden.rawValue, .some(let message)):
            self = .exceededLimit(message: message)
        default:
            self = .unknown
        }
    }
    
    public var statusCode: Int? {
        switch self {
        case .invalidIP: return StatusCode.badRequest.rawValue
        case .invalidAPIKey: return StatusCode.unauthorized.rawValue
        case .exceededLimit: return StatusCode.forbidden.rawValue
        case .invalidResponse(let statusCode): return statusCode
        case .unknown: return nil
        }
    }
    
    public var message: String {
        switch self {
        case .invalidIP(let message),
             .invalidAPIKey(let message),
             .exceededLimit(let message):
            return message
        case .invalidResponse(let statusCode):
            return HTTPURLResponse.localizedString(forStatusCode: statusCode)
        case .unknown:
            return "Unknown Error"
        }
    }
    
}

extension IPDataError: Error {
    
    public var localizedDescription: String {
        return message
    }
    
}

extension IPDataError: LocalizedError {
    
    public var errorDescription: String? {
        return message
    }
    
    public var failureReason: String? {
        return message
    }
    
    public var helpAnchor: String? {
        return message
    }
    
    public var recoverySuggestion: String? {
        return message
    }
    
}
