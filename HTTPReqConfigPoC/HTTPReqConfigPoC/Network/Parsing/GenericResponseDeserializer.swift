import UIKit

class GenericResponseDeserializer<T:ResponseProtocol>: ResponseDeserializer {

    //Should return Codable object?
    func parse(_ data: Data?) throws -> (ResponseProtocol?) {
        
        guard let dataNonNull = data else {
            
            throw NSError(domain: "Parsing Error", code: 500, userInfo: ["Description":"Parsing error. Data is empty."])
        }
        
        return try JSONDecoder().decode(T.self, from: dataNonNull)
    }
}
