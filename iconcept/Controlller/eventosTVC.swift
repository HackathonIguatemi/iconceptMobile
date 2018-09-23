//
//  eventosTVC.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class eventosTVC: UITableViewCell {

    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var localLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(evento : Eventos){
        DataService.ds.REF_PROMOCAO.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
//                    print("DOKI: \(snap)")
                    if snap.key == evento.key {
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                            if let img = postDict["URL"] as? String {
                                if let data = NSData(contentsOf: NSURL(string: img) as! URL) {
                                    self.imgView.image  = UIImage(data: data as Data)
                                }
                            }
                            self.tituloLbl.text = "\(postDict["nome"] as? String)"
                            self.localLbl.text = "\(postDict["local"] as? String), \(postDict["data"])"
//                        self.dataLbl.text = "\(personal.data), \(personal.horainicial) - \(personal.horafinal)"
//                        self.consultorLbl.text = "\(personal.consultor), \(personal.local)"
                        }
                    }
                }
            }
        })
    }
    
}
