//
//  ListCollectionViewCell+Extension.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import UIKit

extension UICollectionViewListCell {
    
    func setup(item: Item) {
        var content = defaultContentConfiguration()
        content.text = item.title
        content.image = UIImage(named: item.imageName)
        content.imageProperties.maximumSize = .init(width: 60, height: 60)
        content.imageProperties.cornerRadius = 30
        contentConfiguration = content
    }
}
