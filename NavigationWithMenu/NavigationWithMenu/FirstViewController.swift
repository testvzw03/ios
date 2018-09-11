import UIKit

class FirstViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello World!"
    }
    
    override func rightNavBarOptions() -> [NavButtonEnum] {
        return [NavButtonEnum.Help,NavButtonEnum.Notifications,NavButtonEnum.ChangeTextSize]
    }
    
    @IBAction func gotoSecondViewController(sender:UIButton?) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        
        self.navigationController?.pushViewController(secondViewController!, animated: true)
    }
}

