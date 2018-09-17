import UIKit
import os.log

class Utils: NSObject {
    
    static func dispatchOnMain(execute:@escaping ()->()) {
        DispatchQueue.main.async(execute: execute)
    }

    static func showAlert(_ viewController:UIViewController!,title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
            
        }))
        
        viewController.present(alertController, animated: true, completion:nil)
    }

    static func logMessage(message:String) {
        os_log("%@", log: OSLog.default, type: OSLogType.info, message)
    }
    
    ////////
    //Converting json to data
    static func dataFromJson(_ json:[String:AnyObject]!) -> Data? {
        
        var data = Data()
        
        if let _ = json {
            do {
                data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.sortedKeys)
            } catch {
                Utils.logMessage(message: "Exception when converting json to data object.")
                data = Data()
            }
        }
        
        return data
    }
    
    static func requestUrlWithParams(_ urlString:String!, params:[String:String]!) -> URL! {
        
        var reqUrl:URL! = nil
        
        if params.keys.count == 0 {
            reqUrl = URL(string: urlString)
            
        } else {
            
            var queryItems:[URLQueryItem] = []
            
            params.forEach({ (key:String, value:String) in
                queryItems.append(URLQueryItem(name: key, value: value))
            })
            
            let urlComps = NSURLComponents(string: urlString)
            urlComps?.queryItems = queryItems
            
            reqUrl = urlComps?.url
        }
        
        return reqUrl
    }
}
