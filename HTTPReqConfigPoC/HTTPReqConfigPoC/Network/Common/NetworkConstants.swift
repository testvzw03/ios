import UIKit

struct NetworkConstants {

    struct EnvironmentUrls {
        //static let baseUrlDev = "https://maps.googleapis.com/maps/api"
        static let baseUrlDev = "http://localhost:3000"
        static let baseUrlQA = "http://api.myservice.com/1.1/qa/v1"
        static let baseUrlPreprod = "http://api.myservice.com/1.1/preprod/v1"
    }

    struct Uri {
        static let testAuthorization = "testauthorization"
        static let testBadRequest = "testbadrequest"
        static let book = "book/%@"
        static let googlePlaces = "place/details/json"
        static let testget = "testget"
        static let testPost = "testpost"
        static let testAllOk = "allOk"
        static let testBasicAuth = "testBasicAuth"
    }
    
    struct HeaderKeys {
        static let contentType = "Content-Type"
        static let acceptType = "Accept"
    }
    
    enum ResponseCommonKeys: String, CodingKey {
        case statusCode = "statusCode"
        case statusMessage = "statusMessage"
    }
    
    struct ManagerConstants {
        static let defaultTimeInterval:TimeInterval = 30
        static let networkQueueName = "Network Manager"
        static let maxConcurrentOperationsCount = 4
    }
}

enum HttpMethod:String {
    
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case INSERT = "INSERT"
    case UPDATE = "UPDATE"
    
    init?(_ method:String) {
        self.init(rawValue: method)
    }
}

enum ContentType:String {
    
    case json = "application/json"
    case html = "text/html"
    case xml = "application/xml"
    case plain = "text/plain"
    case form = "application/x-www-form-urlencoded"
    
    init?(_ contentType:String) {
        self.init(rawValue: contentType)
    }
}

//MARK: Callbacks

typealias RequestCallback = ((ResponseProtocol?, Error?) -> ())
