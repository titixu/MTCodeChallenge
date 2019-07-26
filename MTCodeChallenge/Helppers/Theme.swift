//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

// A common place for the UI constants
// This also can be extent to support iOS Dark Mode in the coming iOS 13
extension UIColor {
    static var appBackground: UIColor {
        return UIColor.orange
    }
    
    static var overlay: UIColor {
        return UIColor(displayP3Red: 222.0/256, green: 97.0/256, blue: 45.0/256, alpha: 1.0)
    }
    
    static var textColor: UIColor {
        return UIColor.white
    }
}

extension CGFloat {
    static var padding: CGFloat {
        return 20.0
    }
}
