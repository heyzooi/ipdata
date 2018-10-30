import Foundation

public enum Result<SuccessType> {
    
    case success(SuccessType)
    case failure(Error)
    
}
