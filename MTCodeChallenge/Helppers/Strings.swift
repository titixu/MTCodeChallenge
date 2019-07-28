//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

extension Double {
    
    // get the currency string of the value
    // default is JPY currency
    var currency: String {
        return currency(locale: Locale(identifier: "jp_JP"))
        
    }
    
    var currencyUSD: String {
        return currency(locale: Locale(identifier: "us_US"))
    }
    
    // get the currency string with a locale
    func currency(locale: Locale) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currencyISOCode
        numberFormatter.locale = locale
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""

    }
}
