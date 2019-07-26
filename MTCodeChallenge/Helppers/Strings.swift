//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

extension Double {
    var currency: String {
        let numberFormatter = NumberFormatter()

        // Looks like a sytem bug currencyISOCode string is missing the comma in the simulator
        numberFormatter.numberStyle = .currencyISOCode
        numberFormatter.locale = Locale(identifier: "jp_JP")
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
