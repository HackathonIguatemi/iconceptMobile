//
//  promocaoDetalheVC.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class promocaoDetalheVC: UIViewController {

    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var localLbl: UILabel!
    @IBOutlet weak var validadeLbl: UILabel!
    @IBOutlet weak var descricaoLbl: UILabel!
    @IBOutlet weak var progressoLbl: UILabel!
    
    @IBOutlet weak var porcentagemLbl: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    
    var promocaoID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    DataService.ds.REF_PROMOCAO.child(promocaoID).observe(.value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
        self.tituloLbl.text = value?["nome"] as? String
        self.localLbl.text = value?["local"] as? String
        self.validadeLbl.text = value?["data"] as? String
        self.descricaoLbl.text = value?["descricao"] as? String
        DataService.ds.REF_USER_CURRENT.child("promocoes").child(self.promocaoID).observe(.value , with: {(snapshot2) in
            let value2 = snapshot2.value as? NSDictionary
            let valor = value2?["valorTotal"] as? Double
            self.progressoLbl.text = "\(String(format: "%.2f", valor!))/\(String(format: "%.2f", (value?["valorTotal"] as? Double)!))"
            self.progress.progress = Float(valor! / (value?["valorTotal"] as? Double)!)
            self.porcentagemLbl.text = "\(String(format: "%.0f", (self.progress.progress * 100)))%"
        })
    })
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func voltarPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
    }
    
}
