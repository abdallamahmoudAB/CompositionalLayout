//
//  BannerCell.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: "BannerCell", bundle: nil)
    }
        
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setup(_ item: Item) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        imageView.image = UIImage(named: item.imageName)
    }

}
