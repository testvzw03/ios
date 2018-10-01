import UIKit

class ErrorUtils: NSObject {
    
    static func showError(_ errorState:ErrorState, error: Error?, statusCode: Int?) {
        
        guard let errorViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ErrorViewController") as? ErrorViewController else {
            return
        }
        
        var title:String?
        var errorMessage:String?
        
        let nsErr = error as NSError?
        
        switch errorState {
        case .authorizationError:
            title = "Unauthorized"
            errorMessage = "User not authorized. This could be due to the session being timed out. Please log in again."
        case .networkError:
            title = nsErr?.domain
            errorMessage = nsErr?.localizedDescription
        case .parseError:
            title = "Call completed, Parser error"
            errorMessage = nsErr?.localizedDescription
        case .serverError:
            let statusCodeNonNull = statusCode ?? -1
            title =  String(format: "Server Error %d", statusCodeNonNull)
            errorMessage = "Incomplete or unknown response from server."
        case .unknownError:
            title = "Unknown Error"
            errorMessage = "Network Request completed incorrectly due to an unknown error."
        }
        
        errorViewController.title = title
        errorViewController.errorMessage = errorMessage
        
        let navController = UINavigationController(rootViewController: errorViewController)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: {})
    }
}
