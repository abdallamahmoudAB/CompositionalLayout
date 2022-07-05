//
//  Item+Stubs.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import Foundation

extension Item {
    
    static var storiesCarouselItems: [Item] {
        loadStubs(filename: "grid_carousel_items")
    }

    static var bannerCarouselItems: [Item] {
        loadStubs(filename: "banner_carousel_items")
    }
    
    static var columnItems: [Item] {
        loadStubs(filename: "sub_items")
    }
    
    static var listItems: [Item] {
        loadStubs(filename: "basic_items")
    }
    
    static var gridItems: [Item] {
        loadStubs(filename: "grid_items")
    }
    
    fileprivate static func loadStubs(filename: String) -> [Self] {
        do {
            let stubs: [Item] = try Bundle.main.loadAndDecodeJSON(filename: filename)
            return stubs
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    
}
