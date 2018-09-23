//
//  AgendaTVC.swift
//  
//
//  Created by Carlos Doki on 23/09/18.
//

import UIKit
import Firebase

class AgendaTVC: UITableViewCell {

    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var consultorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(personal : Personal){
        //20 de Setembro, 16:00 - 17:00h
        //Consultor Fabio Augusto, Iguatemi JK
        
        self.dataLbl.text = "\(personal.data), \(personal.horainicial) - \(personal.horafinal)"
        self.consultorLbl.text = "\(personal.consultor), \(personal.local)"
        
    }
    
}
