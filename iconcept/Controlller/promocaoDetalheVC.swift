//
//  promocaoDetalheVC.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class promocaoDetalheVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var localLbl: UILabel!
    @IBOutlet weak var validadeLbl: UILabel!
    @IBOutlet weak var descricaoLbl: UILabel!
    @IBOutlet weak var progressoLbl: UILabel!
    
    @IBOutlet weak var porcentagemLbl: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var historicoCompraTV: UITableView!
    
    var promocaoID = ""
    var promocoesCliente = [PromocoesCliente]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historicoCompraTV.delegate = self
        historicoCompraTV.dataSource = self

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
        
            if let snapshot2 = snapshot2.children.allObjects as? [DataSnapshot] {
                for snap2 in snapshot2 {
                    if let postDict2 = snap2.value as? Dictionary<String, AnyObject> {
                        let key = snap2.key
                        let post = PromocoesCliente(postKey: key, postData: postDict2)
                        self.promocoesCliente.append(post)
                    }
                }
            }
            self.historicoCompraTV.reloadData()
        })
    })
    
    }
    

    @IBAction func voltarPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promocoesCliente.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let promocao = promocoesCliente[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? promocaoDetalheTVC {
            cell.configureCell(promocao : promocao)
            return cell
        }
        return promocaoDetalheTVC()
    }
    
}
