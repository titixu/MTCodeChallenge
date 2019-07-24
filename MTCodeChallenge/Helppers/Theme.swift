//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

// A common place for the UI constants
// This also can be extent to support iOS Dark Mode in the coming iOS 13
extension UIColor {
    static var appBackground: UIColor {
        return UIColor(displayP3Red: 237.0/256, green: 69.0/256, blue: 34.0/256, alpha: 1.0)
    }
    
    static var overlay: UIColor {
        return UIColor(displayP3Red: 230.0/256, green: 81.0/256, blue: 42.0/256, alpha: 1.0)
    }
    
    static var textColor: UIColor {
        return UIColor.white
    }
}
