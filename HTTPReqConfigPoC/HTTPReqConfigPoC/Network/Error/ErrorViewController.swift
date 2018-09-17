import UIKit

class ErrorViewController: UIViewController {

    var errorMessage:String?
    
    @IBOutlet weak var errorLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = self.errorMessage {
            self.errorLabel.text = self.errorMessage!
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(close))
    }
    
    @objc func close() {
        self.dismiss(animated: true) {
            
        }
    }
}
