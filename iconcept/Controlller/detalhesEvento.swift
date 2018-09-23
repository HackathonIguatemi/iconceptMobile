//
//  detalhesEvento.swift
//  iconcept
//
//  Created by Carlos Doki on 22/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class detalhesEvento: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var textoTxt: UITextView!
    @IBOutlet weak var localLbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    
    @IBOutlet weak var tipoLbl: UILabel!
    
    var eventoID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.ds.REF_PROMOCAO.child(eventoID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.tituloLbl.text = value?["nome"] as? String
            self.textoTxt.text = value?["descricao"] as? String
            self.localLbl.text = value?["local"] as? String
            self.dataLbl.text = value?["data"] as? String
            self.tipoLbl.text = value?["tipo"] as? String
            
            if let img = value?["URL"] as? String {
                if let data = NSData(contentsOf: (NSURL(string: img) as? URL)!) {
                    self.imageView.image  = UIImage(data: data as Data)
                }
            }
        })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func voltarPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func comparecerPressed(_ sender: UIButton) {
    }
    
}
