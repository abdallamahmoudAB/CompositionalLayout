//
//  SectionHeaderTextReusableView.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import UIKit

class SectionHeaderTextReusableView: UICollectionReusableView {
    
    static var nib: UINib {
        UINib(nibName: "SectionHeaderTextReusableView", bundle: nil)
    }
        
    @IBOutlet weak var titleLabel: UILabel!
}
