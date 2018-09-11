import UIKit

class Utils: NSObject {

    static func isTablet() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
}
