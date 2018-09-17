import UIKit

class TestGetRequest:BaseRequestModel {
    
    var bookId:String!
    var isbn:String!
    
    override var requestConfig: RequestConfig {
        return RequestConfig.testget
    }
    
    override func queryParams() -> [String : String]? {
        return ["id":"book_001", "isbn":"9781412108614"]
    }
}

class TestPostRequest:BaseRequestModel {
    
    var bookId:String!
    var isbn:String!
    
    override var requestConfig: RequestConfig {
        return RequestConfig.testpost
    }
    
    override func requestBody() -> [String : AnyObject]? {
        return ["id":"book_001", "isbn":"9781412108614"] as [String:AnyObject]?
    }
}

////////////////////////////////////////////////
////////////////////////////////////////////////
class Test500ErrorRequest: BaseRequestModel {
    
    override var requestConfig: RequestConfig {
        return RequestConfig.serverError
    }
}

////////////////////////////////////////////////
////////////////////////////////////////////////
class TestAuthorizationStatusRequest: BaseRequestModel {
    
    override var requestConfig: RequestConfig {
        return RequestConfig.testAuthorizationStatus
    }
}

////////////////////////////////////////////////
////////////////////////////////////////////////
class TestBadRequest:BaseRequestModel {
    
    override var requestConfig: RequestConfig {
        return RequestConfig.testBadRequest
    }
}

////////////////////////////////////////////////
////////////////////////////////////////////////
class TestAllOkRequest:BaseRequestModel {
    
    override var requestConfig: RequestConfig {
        return RequestConfig.testAllOk
    }
}

class TestBasicAuthenticationRequest:BaseRequestModel {
    override var requestConfig: RequestConfig {
        return RequestConfig.testBasicAuth
    }
}

class TestSSLPinningRequest:BaseRequestModel {
    override var requestConfig: RequestConfig {
        return RequestConfig.testSSLPinning
    }
}


