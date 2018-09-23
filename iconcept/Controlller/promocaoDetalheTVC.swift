//
//  promocaoDetalheTVC.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class promocaoDetalheTVC: UITableViewCell {

    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var valorLbl: UILabel!
    @IBOutlet weak var lojaLbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(promocao : PromocoesCliente){
        self.itemLbl.text = promocao.item
        self.valorLbl.text = String("R$ \(String(format: "%.2f", promocao.valor))")
        self.lojaLbl.text = promocao.loja
        self.dataLbl.text = promocao.data
        
    }

}
