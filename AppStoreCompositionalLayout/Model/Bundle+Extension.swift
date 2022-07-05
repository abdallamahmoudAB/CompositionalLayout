//
//  Bundle+Extension.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import Foundation

fileprivate let jsonDecoder = JSONDecoder()

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D {
        guard let url = url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])
        }
        return try jsonDecoder.decode(D.self, from: data)
    }
    
}
