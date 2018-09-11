import UIKit
import Foundation

struct Constants {
    static let NavButtonOptionWidth:CGFloat = 25.0
    static let NavButtonOptionHeight:CGFloat = 35.0
    static let NavOptionNotificationName:String = "NavOptionNotificationName"
    
    static let ToggleMenuAnimationDuration = 0.3
}

enum NavButtonEnum:UInt8 {
    
    //Flags for left navigation menu
    case None =             0b00000000      //0
    case Back =             0b00000001      //1
    case Menu =             0b00000010      //2
    
    //Flags for right navigation menu
    case Notifications =    0b00010000      //16
    case Help =             0b00100000      //32
    case ChangeTextSize =   0b01000000      //64
    case CallCustomerCare = 0b10000000      //128
    
    private func image() -> UIImage? {
        
        switch self {

        case .None:
            return nil
        case .Back:
            return UIImage(named: "back")
        case .Menu:
            return UIImage(named: "menu")
        case .Notifications:
            return UIImage(named: "notifications")
        case .Help:
            return UIImage(named: "help")
        case .ChangeTextSize:
            return UIImage(named: "textsize")
        case .CallCustomerCare:
            return UIImage(named: "callcc")
        }
    }
    
    /*
    func descrption()->String {
     
        switch self {
     
        case .None:
            return "None"
        case .Back:
            return "Back"
        case .Menu:
            return "Menu"
        case .Help:
            return "Help"
        case .Chat:
            return "Chat"
        case .Notifications:
            return "Notifications"
        }
    }*/
    
    func navButtonView() -> NavOptionButton? {
        
        if(self == .None) {
            return nil
        }
        
        let image = self.image()
        let navButton = NavOptionButton(frame: .zero)
        navButton.translatesAutoresizingMaskIntoConstraints = false
        navButton.setImage(image, for: UIControlState.normal)
        navButton.imageView?.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([NSLayoutConstraint(item: navButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: Constants.NavButtonOptionWidth),
                                     NSLayoutConstraint(item: navButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: Constants.NavButtonOptionHeight)])
        
        return navButton
    }
}

