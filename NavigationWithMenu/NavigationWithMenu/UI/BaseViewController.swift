import UIKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let _ = self.navigationController as? NavigationController {
            configuerNavigation()
        }
    }
    
    func configuerNavigation() {
        
        //Configure Left Bar Button Item
        let rightNavOptions = rightNavBarOptions()

        let leftNavBarOptions:[NavButtonEnum] = []
        
        //Setting left bar button item
        let leftNavOptsView = createLeftNavButtonView(leftNavBarOptions)
        if(leftNavOptsView != nil) {
            let leftBarButtonItem = UIBarButtonItem(customView: leftNavOptsView!)
            self.navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        }

        //Setting right bar button item
        let rightNavOptsView = createNavButtonView(rightNavOptions)
        if(rightNavOptsView != nil) {
            let rightBarButtonItem = UIBarButtonItem(customView: rightNavOptsView!)
            self.navigationItem.setRightBarButton(rightBarButtonItem, animated: false)
        }
    }
    
    func createLeftNavButtonView(_ menuOptions:[NavButtonEnum]) -> UIView? {
        
        var mutableMenuOptions:[NavButtonEnum] = menuOptions
        
        if(self.navigationController?.topViewController != self.navigationController?.viewControllers[0]) {
            mutableMenuOptions.append(NavButtonEnum.Back)
        }
        
        if(self.displayMenu()) {
            mutableMenuOptions.append(NavButtonEnum.Menu)
        }
        
        return self.createNavButtonView(mutableMenuOptions)
    }
    
    func createNavButtonView(_ navOptions:[NavButtonEnum]) -> UIView?  {
        
        let navButtonsContainer = UIView()
        navButtonsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        var navOptionFlags:UInt8 = 0b0
        
        for i in 0...navOptions.count-1 {
            navOptionFlags = navOptionFlags|navOptions[i].rawValue
        }
        
        var counter:UInt8 = 0b1
        
        var navOptionButtons:[UIButton] = []
        
        repeat {
            
            let navOptionFlag = NavButtonEnum(rawValue: counter&navOptionFlags)
            
            if(navOptionFlag != nil && navOptionFlag != NavButtonEnum.None) {
                
                let button = navOptionFlag?.navButtonView()
                
                button?.navOption = navOptionFlag
                
                if(button != nil) {
                    navOptionButtons.append(button!)
                }
            }
            
            counter = counter<<0b1
            
        } while (counter>0)
        
        //If no nav options, return nil view.
        if(navOptionButtons.count == 0) {
            return nil
        }
        
        for i in 0...(navOptionButtons.count-1) {
            
            let navOptionButton = navOptionButtons[i]
            
            navOptionButton.addTarget(self, action: #selector(navOptionTapped(sender:)), for: .touchUpInside)
            
            navButtonsContainer.addSubview(navOptionButton)
            navOptionButton.translatesAutoresizingMaskIntoConstraints = false
            
            //Top and bottom of nav option button
            NSLayoutConstraint.activate([NSLayoutConstraint(item: navOptionButton, attribute: .top, relatedBy: .equal, toItem:navButtonsContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0),NSLayoutConstraint(item: navOptionButton, attribute: .bottom, relatedBy: .equal, toItem:navButtonsContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)])
            
            if(i == 0) {
                NSLayoutConstraint.activate([NSLayoutConstraint(item: navOptionButton, attribute: .left, relatedBy: .equal, toItem: navButtonsContainer, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)])
            } else {
            
                let prevButton:UIButton? = navOptionButtons[i-1]
                NSLayoutConstraint.activate([NSLayoutConstraint(item: navOptionButton, attribute: .left, relatedBy: .equal, toItem: prevButton, attribute: .right, multiplier: 1, constant: 0)])
            }
            
            if(i == navOptionButtons.count-1) {
                NSLayoutConstraint.activate([NSLayoutConstraint(item: navOptionButton, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: navButtonsContainer, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)])
            }
        }

        return navButtonsContainer
    }
    
    @objc func navOptionTapped(sender:NavOptionButton) {
        
        let navOption:NavButtonEnum = sender.navOption!
        
        switch navOption {
        case .Back:
            self.navigationController?.popViewController(animated: true)
        case .Menu:
            launchMenu(sender)
        case .Notifications:
            launchAlerts()
        case .Help:
            launchHelp()
        case .ChangeTextSize:
            launchChangeTextSize()
        case .CallCustomerCare:
            launchCallCustomerCare()
        case .None:
            print("Fail Safe")
        }
    }
    
    func launchMenu(_ sender:NavOptionButton) {
        
        if let navController = self.navigationController as? NavigationController {
            navController.toggleMenu(sender)
        }
    }
    
    func launchAlerts() {
        let alertController = UIAlertController(title: nil, message: "Launch Alerts", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            alertController.dismiss(animated: true, completion: {})
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: {})
    }

    func launchHelp() {
        let alertController = UIAlertController(title: nil, message: "Launch Help", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            alertController.dismiss(animated: true, completion: {})
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: {})
    }
    
    func launchChangeTextSize() {
        let alertController = UIAlertController(title: nil, message: "Launch Change Text Size", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            alertController.dismiss(animated: true, completion: {})
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: {})
    }
    
    func launchCallCustomerCare() {
        let alertController = UIAlertController(title: nil, message: "Launch Call Customer Care", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            alertController.dismiss(animated: true, completion: {})
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: {})
    }
    
    //MARK: To be overriden
    func rightNavBarOptions() -> [NavButtonEnum] {
        
        return [NavButtonEnum.None]
    }
    
    func displayMenu() -> Bool {
        return true
    }
}
