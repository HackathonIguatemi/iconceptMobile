//
//  collectionCell.swift
//  iconcept
//
//  Created by Carlos Doki on 22/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit

class collectionCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var collectionItem: Preferencias!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ collectionItem: Preferencias){
        if let img = collectionItem.URL as? String {
            if let data = NSData(contentsOf: NSURL(string: img) as! URL) {
                self.thumbImg.image  = UIImage(data: data as Data)
            }
        }
        self.button.setImage(UIImage(named: "\(collectionItem.nome)"), for: .normal )
        self.collectionItem = collectionItem

    }
}
