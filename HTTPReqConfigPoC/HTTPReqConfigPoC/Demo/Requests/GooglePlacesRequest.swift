import UIKit

class GooglePlacesRequest: BaseRequestModel {
    
    var placeId:String?
    var requestFormatType:String?
    var requestPayload:[String:String]?
    
    override func requestBody() -> [String : AnyObject] {
        
        var params:[String:AnyObject] = [:]
        
        if let _ = self.placeId {
            params["placeId"] = self.placeId as AnyObject
        }
        
        if let _ = self.requestFormatType {
            params["requestType"] = self.requestFormatType as AnyObject
        }
        
        if let _ = self.requestPayload {
            params["requestPayload"] = self.requestPayload as AnyObject
        }

        return params
    }
}
