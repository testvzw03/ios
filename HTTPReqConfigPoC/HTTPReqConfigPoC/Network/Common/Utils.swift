import UIKit
import os.log

class Utils: NSObject {
    
    static func dispatchOnMain(execute:@escaping ()->()) {
        DispatchQueue.main.async(execute: execute)
    }

    static func showAlert(_ viewController:UIViewController?, title:String?, message:String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        viewController?.present(alertController, animated: true, completion:nil)
    }

    static func logMessage(message:String?) {
        if let messageNonNull = message {
            os_log("%@", log: OSLog.default, type: OSLogType.info, messageNonNull)
        }
    }
    
    ////////
    //Converting json to data
    static func dataFromJson(_ json:[String:AnyObject]?) -> Data? {
        
        guard let jsonNonNull = json else {
            return nil
        }
        
        var data:Data?
        
        do {
            data = try JSONSerialization.data(withJSONObject: jsonNonNull, options: JSONSerialization.WritingOptions.sortedKeys)
        } catch {
            Utils.logMessage(message: "Exception when converting json to data object.")
        }

        return data
    }
    
    static func requestUrlWithParams(_ urlString:String?, params:[String:String]?) -> URL? {
        
        guard let urlStringNonNull = urlString else {
            return nil
        }
        
        guard let paramsNonNull = params, params?.keys.isEmpty == false else {
            return URL(string: urlStringNonNull)
        }
        
        var queryItems:[URLQueryItem] = []
        
        paramsNonNull.forEach({ (key:String, value:String) in
            queryItems.append(URLQueryItem(name: key, value: value))
        })

        let urlComps = NSURLComponents(string: urlStringNonNull)
        urlComps?.queryItems = queryItems
        
        return urlComps?.url
    }
}
