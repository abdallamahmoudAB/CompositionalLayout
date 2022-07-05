//
//  AvatarCell.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: "AvatarCell", bundle: nil)
    }
    
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    func setup(item: Item) {
        textLabel.text = item.title
        imageView.image = UIImage(named: item.imageName)
    }
}

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
}
