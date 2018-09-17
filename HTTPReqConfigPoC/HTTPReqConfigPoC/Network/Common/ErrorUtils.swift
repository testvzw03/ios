import UIKit

class ErrorUtils: NSObject {

    static func showConnectivityError(error:Error) {
        
        let errorViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ErrorViewController") as! ErrorViewController
        
        let nsErr = error as NSError
        errorViewController.title = nsErr.domain
        errorViewController.errorMessage = nsErr.localizedDescription
        
        let navController = UINavigationController(rootViewController: errorViewController)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: {})
    }
    
    static func showParserError(message:String) {
        
        let errorViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ErrorViewController") as! ErrorViewController
        
        errorViewController.title = "Call Completed, Parser Error"
        errorViewController.errorMessage = message
        
        let navController = UINavigationController(rootViewController: errorViewController)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: {})
    }
    
    static func showUnknownError() {
        
        let errorViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ErrorViewController") as! ErrorViewController
        
        errorViewController.title = "Unknown Error"
        errorViewController.errorMessage = "Network Request completed incorrectly due to an unknown error."
        
        let navController = UINavigationController(rootViewController: errorViewController)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: {})
    }
    
    static func showAuthorizationError(message:String = "User not authorized. This could be due to the session being timed out. Please log in again.") {
        
        let errorViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ErrorViewController") as! ErrorViewController
        
        errorViewController.title = "Unauthorized"
        errorViewController.errorMessage = message
        
        let navController = UINavigationController(rootViewController: errorViewController)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: {})
    }
    
    static func showServerError(statusCode:Int) {
        
        let errorViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ErrorViewController") as! ErrorViewController
        
        errorViewController.title = "Server Error \(statusCode)"
        errorViewController.errorMessage = "Incomplete or unknown response from server."
        
        let navController = UINavigationController(rootViewController: errorViewController)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: {})
    }
}
