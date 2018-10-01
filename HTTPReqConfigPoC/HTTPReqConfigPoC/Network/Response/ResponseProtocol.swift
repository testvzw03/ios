import UIKit

protocol ResponseProtocol:Decodable {
    
    var statusCode: Int? { get set }
    var statusMessage: String? { get set }
}

extension ResponseProtocol {
    
    func readCommonProperties(from decoder: Decoder) throws -> (Int, String)  {
        let container = try decoder.container(keyedBy: NetworkConstants.ResponseCommonKeys.self)
        let errCode = try container.decode(Int.self, forKey: .statusCode)
        let errMsg = try container.decode(String.self, forKey: .statusMessage)
        
        return (errCode, errMsg)
    }
}
