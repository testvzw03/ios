import UIKit

class BaseRequestModel: NSObject {
    
    var requestConfig: RequestConfig {
        fatalError("Must override property")
    }
    
    func requestBody() -> [String:AnyObject]? {
        return nil
    }
    
    func queryParams() -> [String:String]? {
        return nil
    }
    
    func urlRequest() -> URLRequest {
        
        var urlRequest = URLRequest(url: URL(string: self.requestConfig.requestUrl())!,
                                    cachePolicy: self.requestConfig.cachePolicy()!,
                                    timeoutInterval: self.requestConfig.timeOut())

        //Method
        urlRequest.httpMethod = self.requestConfig.method().rawValue

        //Headers
        urlRequest.allHTTPHeaderFields = self.readHeaders()

        //Set query params
        if let queryParams = self.queryParams() {
            urlRequest.url = Utils.requestUrlWithParams(self.requestConfig.requestUrl(), params:queryParams)
        }

        //Set request body
        if let reqParams = self.requestBody() {
            urlRequest.httpBody = Utils.dataFromJson(reqParams)
        }

        return urlRequest
    }

    func readHeaders() -> [String:String] {

        var headers:[String:String] = [:]

        //Add all headers
        
        //Accept Type and Content Type
        headers[NetworkConstants.HeaderKeys.contentType] = requestConfig.contentType().rawValue
        headers[NetworkConstants.HeaderKeys.acceptType] = requestConfig.acceptType().rawValue
        
        return headers
    }
}
