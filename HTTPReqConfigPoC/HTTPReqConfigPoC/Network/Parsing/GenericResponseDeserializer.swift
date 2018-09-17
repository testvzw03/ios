import UIKit

class GenericResponseDeserializer<T:ResponseProtocol>: ResponseDeserializer {

    //Should return Codable object?
    func parse(_ data: Data?) -> (ResponseProtocol?, NSError?) {
        
        var responseObj:ResponseProtocol? = nil
        var parsingError:NSError? = nil

        guard data != nil else {
            
            let err = NSError(domain: "Parsing Error", code: 500, userInfo: ["Description":"Parsing error. Data is empty."])
            return (nil, err)
        }
        do {
            responseObj = try JSONDecoder().decode(T.self, from: data!)
            parsingError = nil
        }
        catch let error as NSError {
            parsingError = error
            responseObj = nil
        }
        
        return (responseObj, parsingError)
    }

}
