//
//  Item.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import Foundation

struct Item: Codable, Hashable {
    
    let id: String
    let title: String
    let subtitle: String?
    let imageName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.subtitle == rhs.subtitle &&
            lhs.imageName == rhs.imageName
    }
    
}
