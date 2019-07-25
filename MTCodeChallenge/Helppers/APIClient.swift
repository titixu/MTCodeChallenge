//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

// Fetch account and transaction object form sample file
// Can be easily change to do network fetch, by just changing the APIClient, and no need to change anything outside.
struct APIClient {

    func loadAccounts(_ completion: ([Account]) -> Void) {
        guard let data = loadJsonFile("accounts", withExtension: "json") else {
            // Alway return empty array where there is something wrong
            completion([]); return
        }
        
        // Replace with Async calls if fetching from the remote server
        let object = try? JSONDecoder.custom.decode(AccountsJSONObject.self, from: data)
        
        return completion(object?.accounts ?? [])
    }

    func loadTransactions(for accountID: Int, completion: ([Transaction]) -> Void) {

        // Replace with Async calls if fetching from the remote server
        let result = loadJSONFiles(["transactions_1", "transactions_2", "transactions_3"], withExtension: "json")
            // convert data into transaction object and flat map into one transaction array
            .flatMap { (data) -> [Transaction] in
            let object = try? JSONDecoder.custom.decode(TransactionsJSONObject.self, from: data)
            return object?.transactions ?? []
            }
            // only return the transactions with the accountID
            .filter { $0.accountId == accountID }
        
        completion(result)
    }
}

// this is for loading the sample json files in the main bundle
// Do be carefull, as LogicTests doesn't have access to main bundle
fileprivate func loadJsonFile(_ name: String, withExtension: String) -> Data? {
    guard let url = Bundle.main.url(forResource: name, withExtension: withExtension) else {
        return nil
    }
    return try? Data.init(contentsOf: url)
}

// load files and return data array, it will auto ignore the nil data
fileprivate func loadJSONFiles(_ names: [String], withExtension: String) -> [Data] {
    return names.compactMap {
        loadJsonFile($0, withExtension: withExtension)
    }
}

// this is for decoding the date string from the transaction json
extension DateFormatter {
    static var jsonDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }
}

extension JSONDecoder {
    // JSONDecoder featuring auto convert snake cases into camel cases
    // also convert date string to Date object
    static var custom: JSONDecoder {
        let decoder = JSONDecoder()
        // this will auto convert snake case to camel case
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // this only works where there is only one date format in the object
        decoder.dateDecodingStrategy = .formatted(DateFormatter.jsonDateFormatter)
        return decoder
    }
}
