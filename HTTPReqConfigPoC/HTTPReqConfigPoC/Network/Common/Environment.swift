import UIKit

enum Environment {
    
    case Dev
    case QA
    case Preprod
    
    private static func current() -> Environment {
        return .Dev
    }
    
    static func baseUrl() -> String {
        
        var baseUrl:String = NetworkConstants.EnvironmentUrls.baseUrlDev
        
        switch Environment.current() {
        case .Dev:
            baseUrl = NetworkConstants.EnvironmentUrls.baseUrlDev
        case .QA:
            baseUrl = NetworkConstants.EnvironmentUrls.baseUrlQA
        case .Preprod:
            baseUrl = NetworkConstants.EnvironmentUrls.baseUrlPreprod
        }
        return baseUrl
    }
    
    static func contentUrl() -> String {
        
        var contentUrl = "http://content.google.com/strings.json"
        
        switch Environment.current() {
        case .Dev:
            contentUrl = "http://content.google.com/dev/strings.json"
        case .QA:
            contentUrl = "http://content.google.com/qa/strings.json"
        case .Preprod:
            contentUrl = "http://content.google.com/preprod/strings.json"
        }
        
        return contentUrl
    }
}

