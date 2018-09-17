import UIKit

extension AppDelegate {
    
    func startActivityIndicator() {
        
        if self.activityIndicatorContainer == nil {
            
            let activityContainer = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            activityContainer.backgroundColor = UIColor(white: 0.5, alpha: 1)
            activityContainer.layer.cornerRadius = 15
            self.window?.addSubview(activityContainer)
            if let center = self.window?.center {
                activityContainer.center = center
            }
            
            let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            activityIndicatorView.color = UIColor.white
            activityContainer.addSubview(activityIndicatorView)
            activityIndicatorView.center = CGPoint(x: 50, y: 50)

            self.activityIndicatorContainer = activityContainer
        }
        
        self.window?.isUserInteractionEnabled = false
        self.activityIndicatorContainer?.isHidden = false
        if let activityIndicatorView = self.activityIndicatorContainer?.subviews[0] as? UIActivityIndicatorView {
            activityIndicatorView.startAnimating()
            
        }
    }
    
    func stopActivityIndicator() {
        
        self.activityIndicatorContainer?.isHidden = true
        if let activityIndicatorView = self.activityIndicatorContainer?.subviews[0] as? UIActivityIndicatorView {
            activityIndicatorView.stopAnimating()
        }
        self.window?.isUserInteractionEnabled = true
    }
}
