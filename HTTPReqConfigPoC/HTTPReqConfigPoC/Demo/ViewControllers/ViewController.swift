import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testAllOk(_ sender:UIButton) {
        
        NetworkManager.shared().request(from: self, requestModel: TestAllOkRequest()) { (response:ResponseProtocol?, error:Error?) in
            
            if let testResp:TestResponse = response as? TestResponse {
                Utils.showAlert(self, title: "", message: "Call completed successfully")
                Utils.logMessage(message: "Response received. C::\(testResp.c!)")
            } else {
                Utils.logMessage(message: "Response Failure")
            }
        }
    }

    @IBAction func testAuthorizationStatus(_ sender:UIButton) {
        
        let urlRequest = TestAuthorizationStatusRequest()
    
        NetworkManager.shared().request(from:self ,requestModel: urlRequest) { (response:ResponseProtocol?, error:Error?) in
            
            fatalError("Test AUthorization call should fail.")
        }
    }
    
    @IBAction func testBadRequest(_ sender:UIButton) {

        NetworkManager.shared().request(from: self, requestModel: TestBadRequest()) { (response:ResponseProtocol?, error:Error?) in
            
            if error != nil {
                
                Utils.showAlert(self, title: "Unable to fulfill request", message: response?.statusMessage ?? "Error due to client.")
                
            } else {
                
                if let testResp:TestResponse = response as? TestResponse {
                    Utils.logMessage(message: "Response received. C::\(testResp.c!)")
                } else {
                    Utils.logMessage(message: "Response Failure")
                }
            }
        }
    }
    
    @IBAction func testServerError(_ sender:UIButton) {
        
        NetworkManager.shared().request(from: self, requestModel: Test500ErrorRequest()) { (response:ResponseProtocol?, error:Error?) in
            
            fatalError("Call Back should not be called.")
        }
    }
    
    @IBAction func testGetMethod(_ sender:UIButton) {
        
        NetworkManager.shared().request(from: self, requestModel: TestGetRequest()) { (response:ResponseProtocol?, error:Error?) in
            
            if let responseNonNull = response {
                Utils.showAlert(self, title: "", message: (responseNonNull.statusMessage)!)
                Utils.logMessage(message: "Response received. C::\(responseNonNull.statusMessage ?? "")")
            }
        }
    }
    
    
    @IBAction func testPostMethod(_ sender:UIButton) {
        
        NetworkManager.shared().request(from: self, requestModel: TestPostRequest()) { (response:ResponseProtocol?, error:Error?) in
            
            if let responseNonNull = response {
                Utils.showAlert(self, title: "", message: (responseNonNull.statusMessage)!)
                Utils.logMessage(message: "Response received. C::\(responseNonNull.statusMessage ?? "")")
            }
        }
    }
    
    @IBAction func testAuthentication(_ sender:UIButton) {
        
        NetworkManager.shared().request(from: self, requestModel: TestBasicAuthenticationRequest()) { (response:ResponseProtocol?, error:Error?) in
            
            if let responseNonNull = response {
                Utils.showAlert(self, title: "", message: (responseNonNull.statusMessage)!)
                Utils.logMessage(message: "Response received. Status Message::\(responseNonNull)")
            }
        }
    }
    
    @IBAction func testSSLPinning(_ sender:UIButton) {
        NetworkManager.shared().request(from: self, requestModel: TestSSLPinningRequest()) { (response:ResponseProtocol?, error:Error?) in
            
        }
    }
}

