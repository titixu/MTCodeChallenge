//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

// Fetch account and transaction object form sample file
// Can be easily change to do network fetch, by just changing the APIClient, and no need to change anything outside.
struct APIClient {

    func loadAccounts(_ completion: (Data?) -> Void) {
        guard let data = loadJsonFile("accounts", withExtension: "json") else {
            completion(nil); return
        }
        
        return completion(data)
    }
}

fileprivate func loadJsonFile(_ name: String, withExtension: String) -> Data? {
    guard let url = Bundle.main.url(forResource: name, withExtension: withExtension) else {
        return nil
    }
    return try? Data.init(contentsOf: url)
}

extension DateFormatter {
    static var jsonDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ZZZZZ"
        return formatter
    }
}
