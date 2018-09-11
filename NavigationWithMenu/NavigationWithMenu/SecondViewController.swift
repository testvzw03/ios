import UIKit

class SecondViewController: BaseViewController {

    override func rightNavBarOptions() -> [NavButtonEnum] {
        return [NavButtonEnum.Help,NavButtonEnum.Notifications, NavButtonEnum.CallCustomerCare]
    }

    @IBAction func gotoThirdViewController(sender:UIButton) {
        
        let thirdViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController")
        
        self.navigationController?.pushViewController(thirdViewController!, animated: true)
    }

}
