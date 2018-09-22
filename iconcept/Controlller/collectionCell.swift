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
    @IBOutlet weak var nameLbl: UILabel!
    
    var collectionItem: Collection!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ collectionItem: Collection){
        self.collectionItem = collectionItem
//        nameLbl.text = pokemon.name.capitalized
//        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
