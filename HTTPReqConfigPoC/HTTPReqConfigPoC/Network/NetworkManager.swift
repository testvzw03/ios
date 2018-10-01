import UIKit
import os.log

class NetworkManager: NSObject, URLSessionTaskDelegate, URLSessionDelegate {

    var mockNetworkCalls = false
    
    static var _shared:NetworkManager! = nil
    
    private var urlSession:URLSession! = nil
    
    private override init() {
        
        super.init()
        
        let operationQueue = OperationQueue()
        operationQueue.name = NetworkConstants.ManagerConstants.networkQueueName
        operationQueue.maxConcurrentOperationCount = NetworkConstants.ManagerConstants.maxConcurrentOperationsCount
        
        self.urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: operationQueue)
        
    }
    
    static func shared() -> NetworkManager! {
        
        if _shared == nil {
            _shared = NetworkManager()
        }
        
        return _shared
    }
    
    //MARK: Make request to server.
    
    func request(from:UIViewController!, requestModel:BaseRequestModel, callback: @escaping RequestCallback) {
        
        let urlRequest = requestModel.urlRequest()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.startActivityIndicator()
        }
        
        let sessionDataTask = self.urlSession.dataTask(with: urlRequest) { (data:Data?, response:URLResponse?, error:Error?) -> Void in
            
            Utils.dispatchOnMain {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.stopActivityIndicator()
                }
            }
            
            if let responseData = data {
                let responseStr = String.init(data: responseData, encoding: String.Encoding.utf8)
                Utils.logMessage(message: "Response:\(responseStr ?? "")")
            }
            
            if let err = error {
                
                //"SYSTEM ERROR":Error trying to connect to server. Show not reachable to server error.
                Utils.logMessage(message: "Unable to connect to server. \(err.localizedDescription)")
                ErrorUtils.showError(ErrorState.networkError, error: err, statusCode: nil)
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                //Process the response
                self.processResponse(requestModel, httpResponse: httpResponse, data: data, callback: callback)

            } else /* urlResponse == nil */ {
                
                //"SYSTEM ERROR":Request completed incorrectly.
                Utils.logMessage(message: "Unknown error. URL Response is nil.")
                ErrorUtils.showError(ErrorState.unknownError, error: nil, statusCode: nil)
            }
        }
        
        sessionDataTask.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        //Handle Authentication depending on the request url.
        guard let urlStr = task.originalRequest?.url?.absoluteString, urlStr == RequestConfig.testBasicAuth.requestUrl() else {
            Utils.logMessage(message: "Empty Url string")
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
            return
        }
        
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(user: "admin", password: "password", persistence: URLCredential.Persistence.none))
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            
            guard let serverTrust = challenge.protectionSpace.serverTrust else {
                completionHandler(.useCredential, nil)
                return
            }
            
            guard let secCertRef = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
                
                let credential:URLCredential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
                return
            }
            
            let policies = NSMutableArray()
            policies.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))

            SecTrustSetPolicies(serverTrust, policies)
            
            // Evaluate server certificate
            var result: SecTrustResultType = SecTrustResultType(rawValue: 0)!
            SecTrustEvaluate(serverTrust, &result)
            let isServerTrusted:Bool = result == SecTrustResultType.unspecified || result ==  SecTrustResultType.proceed
            
            // Get local and remote cert data
            let remoteCertificateData:NSData = SecCertificateCopyData(secCertRef)
            
            guard let pathToCert = Bundle.main.path(forResource: "github.com", ofType: "cer") else {
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
                return
            }
            
            guard let localCertificate:NSData = NSData(contentsOfFile: pathToCert) else {
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
                return
            }
            
            if (isServerTrusted && remoteCertificateData.isEqual(to: localCertificate as Data)) {
                let credential:URLCredential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
            } else {
                completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
            }
        }
    }
    
    //MARK: Process response
    func processResponse(_ request:BaseRequestModel, httpResponse:HTTPURLResponse, data:Data?, callback:RequestCallback) {
        
        let httpCode:ErrorCode = ErrorCode(errorCode: httpResponse.statusCode)

        do {
            let response = try request.requestConfig.responseParser().parse(data)
            
            if (httpCode == .serverError || httpCode == .unknown || httpCode == .redirection) {
                
                //Server or unknown or redirection. (Currently redirection support not implemented)
                Utils.logMessage(message: "Request Completed with error(server or unknown)")
                ErrorUtils.showError(ErrorState.serverError, error: nil, statusCode: httpResponse.statusCode)
                
            } else if httpCode == .unauthorized {
                
                //Unauthorized.
                Utils.logMessage(message: response?.statusMessage)
                ErrorUtils.showError(ErrorState.authorizationError, error: nil, statusCode: nil)
                
            } else if httpCode == .badRequest {
                
                //Bad Request. Send error to view controller to handle.
                Utils.logMessage(message: response?.statusMessage ?? "Bad Request")
                callback(response, NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: nil))
                
            } else {
                
                //All OK
                Utils.logMessage(message: "All Ok")
                callback(response, nil)
            }
        } catch {
            
            //Error Parsing the response
            Utils.logMessage(message: "Call success but incomplete response/parsing failed.")
            ErrorUtils.showError(ErrorState.parseError, error: error, statusCode: nil)
        }
    }
}
