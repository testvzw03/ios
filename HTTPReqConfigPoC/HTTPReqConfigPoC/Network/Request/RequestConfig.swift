import UIKit

enum RequestConfig {

    case testAuthorizationStatus
    case testBadRequest
    case testAllOk
    case serverError
    case testget
    case testpost
    case testBasicAuth
    case testSSLPinning
    case book(String)
    
    func requestUrl() -> String {

        var baseUrl:String = Environment.baseUrl()
        
        var uri:String = ""

        switch self {
        case .testAuthorizationStatus:
            uri = NetworkConstants.Uri.testAuthorization
        case .testBadRequest:
            uri = NetworkConstants.Uri.testBadRequest
        case .testAllOk:
            uri = NetworkConstants.Uri.testAllOk
        case .serverError:
            baseUrl = Environment.contentUrl()
            uri = NetworkConstants.Uri.testBadRequest
        case .testget:
            uri = NetworkConstants.Uri.testget
        case .testpost:
            uri = NetworkConstants.Uri.testPost
        case .testBasicAuth:
            uri = NetworkConstants.Uri.testBasicAuth
        case .testSSLPinning:
            baseUrl = "https://github.com"
            uri = ""
        case .book(let bookId):
            uri = String(format: "\(NetworkConstants.Uri.book)", bookId)
        }
        
        return baseUrl.appending("/").appending(uri)
    }
    
    func method() -> HttpMethod {
        
        var method = HttpMethod.POST
        
        switch self {
        case .testAuthorizationStatus:
            method = .GET
        case .testBadRequest:
            method = .GET
        case .testAllOk:
            method = .GET
        case .serverError:
            method = .GET
        case .testget:
            method = .GET
        case .book:
            method = .GET
        case .testpost:
            method = .POST
        case .testBasicAuth:
            method = .GET
        case .testSSLPinning:
            method = .GET
        }

        return method
    }
    
     func contentType() -> ContentType {
        
        var contentType:ContentType! = nil
        
        switch self {
        default:
            contentType = .json
        }
        
        return contentType
    }
    
    func acceptType() -> ContentType {
        
        var contentType:ContentType! = nil
        
        switch self {
        default:
            contentType = .json
        }
        
        return contentType
    }
    
    func cachePolicy() -> NSURLRequest.CachePolicy? {
        
        var cachePolicy:NSURLRequest.CachePolicy! = nil
        
        switch self {
        default:
            cachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        }
        
        return cachePolicy
    }
    
    
    func additionalHeaders() -> [String:String] {
        
        var additionalHeaders:[String:String] = [:]
        
        switch self {
        default:
            additionalHeaders[""] = ""
        }
        
        return additionalHeaders
    }
    
    func timeOut() -> TimeInterval {
        
        var timeInterval:TimeInterval! = nil
        
        switch self {
        default:
            timeInterval = NetworkConstants.ManagerConstants.defaultTimeInterval
        }

        return timeInterval
    }
    
    func responseParser() -> ResponseDeserializer {
        
        var parser:ResponseDeserializer! = nil
        
        switch self {
        default:
            parser = GenericResponseDeserializer<TestResponse>()
        }
        
        return parser
    }
    
    //MARK: Mocking Response
    func jsonFileName() -> String {
        
        var localFile:String! = nil
        
        switch self {
        case .testAuthorizationStatus:
            localFile = "testauthorization"
        case .testBadRequest:
            localFile = "testbadrequest"
        case .testAllOk:
            localFile = "testAllOk"
        case .serverError:
            localFile = "serverError"
        case .testget:
            localFile = "testget"
        case .book(let bookId):
            localFile = "book\(bookId)"
        case .testpost:
            localFile = "testpost"
        case .testBasicAuth:
            localFile = "testAuth"
        case .testSSLPinning:
            localFile = "testSSLPinning"
        }
        
        return localFile
    }
}
