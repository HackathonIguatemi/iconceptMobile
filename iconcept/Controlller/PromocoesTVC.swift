//
//  PromocoesTVC.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class PromocoesTVC: UITableViewCell {

    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var valorLbl: UILabel!
    @IBOutlet weak var procentagemLbl: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(promocaoID : String, valor: Double){
        DataService.ds.REF_PROMOCAO.child(promocaoID).observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.tituloLbl.text = value?["nome"] as? String
            self.valorLbl.text = "Progresso R$: \(String(format: "%.2f", valor))/\(String(format: "%.2f", (value?["valorTotal"] as? Double)!))"
            self.progress.progress = Float(valor / (value?["valorTotal"] as? Double)!)
            self.procentagemLbl.text = "\(String(format: "%.0f", (self.progress.progress * 100)))%"
        })
    }

}

