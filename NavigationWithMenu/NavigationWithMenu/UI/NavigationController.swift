import UIKit

class NavigationController: UINavigationController {

    var isMenuDisplayed:Bool! = false
    var menuViewController:MenuViewController! = nil
    var blurEffectView:UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigationBar()
        
        if(UIDevice.current.userInterfaceIdiom == .phone) {
            addMenuAsSlider()
        } else {
            addMenuAsPopOver()
        }
    }
    
    //MARK: Style Navigation Bar
    func styleNavigationBar() {
        let navigationFont = UIFont(name: "Chalkduster", size: 17.0)
        let textAttributes:[NSAttributedStringKey:AnyObject] = [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font: navigationFont!]
        self.navigationBar.titleTextAttributes = textAttributes
    }
    
    func menuSize() -> CGSize {
        if(UIDevice.current.userInterfaceIdiom == .phone) {
            //If Phone
            return CGSize(width: 0.6*self.view.frame.size.width, height: self.view.frame.height)
        } else {
            //If Pad
            return CGSize(width: 300, height: 500)
        }
    }
    
    //MARK: Setting up Menu for Phone and Pad
    //In Case of a pad, menu is displayed as popover.
    func addMenuAsPopOver() {
        
        if(menuViewController == nil) {
            menuViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        }
    }
    
    //In Case of a phone, menu is displayed as slider.
    func addMenuAsSlider() {
        
        if(menuViewController == nil) {
            menuViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            self.view.addSubview((menuViewController.view)!)
        }
        
        menuViewController.view.frame = CGRect(x: -self.menuSize().width, y:  0, width: self.menuSize().width, height: self.menuSize().height)
        menuViewController.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleMenu)))
        menuViewController.view.isHidden = true
        menuViewController.view.isUserInteractionEnabled = false
        
        //Add blur view
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        blurEffectView?.frame = self.view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleMenu)))
        
        self.view.addSubview(blurEffectView!)
        self.view.insertSubview(blurEffectView!, belowSubview: menuViewController.view)
        
        blurEffectView?.isHidden = true
        blurEffectView?.alpha = 0
    }
    
    //MARK: Toggle Menu Methods
    @objc func toggleMenu(_ sender:NavOptionButton) {
        
        //If Pad, follow popover behavior.
        if(UIDevice.current.userInterfaceIdiom == .pad) {
            showMenuAsPopover(sender)
            return
        }
        
        //If phone, slide the menu 'in/out'
        isMenuDisplayed = !isMenuDisplayed
        
        if(isMenuDisplayed) {
            showMenu()
        } else {
            hideMenu()
        }
    }
    
    //Show Menu as Pop Over
    func showMenuAsPopover(_ sender:NavOptionButton) {
        menuViewController.modalPresentationStyle = .popover
        menuViewController.modalTransitionStyle = .crossDissolve
        menuViewController.preferredContentSize = self.menuSize()
        menuViewController.popoverPresentationController?.sourceView = sender
        menuViewController.popoverPresentationController?.sourceRect = CGRect(x: 10, y: 5, width: 20, height: 30)
        menuViewController.popoverPresentationController?.backgroundColor = menuViewController.view.backgroundColor
        self.present(self.menuViewController, animated: true, completion: {})
    }

    
    func hideMenu() {
        
        UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)

        self.menuViewController?.view.frame = CGRect(x: 0, y: 0, width: self.menuSize().width, height: self.view.frame.size.height)
        
        UIView.animate(withDuration: Constants.ToggleMenuAnimationDuration, animations: {
            
            self.menuViewController?.view.frame = CGRect(x: -self.menuSize().width, y: 0, width: self.menuSize().width, height: self.menuSize().height)
            
            self.blurEffectView?.alpha = 0

        }) { (completed:Bool) in
            self.menuViewController.view.isHidden = true
            self.menuViewController.view.isUserInteractionEnabled = false
            self.blurEffectView?.isHidden = true
        }
    }
    
    func showMenu() {
        
        UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
        
        self.menuViewController.view.frame = CGRect(x: -self.menuSize().width, y: 0, width: self.menuSize().width, height: self.menuSize().height)
        self.menuViewController.view.isHidden = false
        self.blurEffectView?.isHidden = false
        self.menuViewController.view.isUserInteractionEnabled = true

        UIView.animate(withDuration: Constants.ToggleMenuAnimationDuration, animations: {
            
            self.blurEffectView?.alpha = 1
            
            self.menuViewController?.view.frame = CGRect(x: 0, y: 0, width: self.menuSize().width, height: self.menuSize().height)
            
        }) { (completed:Bool) in

        }
    }

}
