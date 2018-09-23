//
//  PromocoesVC.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class PromocoesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    

    @IBOutlet weak var promocoesTV: UITableView!
    
    var promocoes = [String]()
    var valorTotal = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        promocoesTV.delegate = self
        promocoesTV.dataSource = self
        
        DataService.ds.REF_USER_CURRENT.child("promocoes").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    self.promocoes.append(snap.key)
                    let value = snap.value as? NSDictionary
                    self.valorTotal.append((value!["valorTotal"] as? Double)! )
                }
            }
            self.promocoesTV.reloadData()
        })
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promocoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let promocao = promocoes[indexPath.row]
        let valor = valorTotal[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PromocoesTVC {
            cell.configureCell(promocaoID : promocao, valor : valor)
            return cell
        }
        return PromocoesTVC()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "detalhepromocao") as! promocaoDetalheVC
        controller.promocaoID = promocoes[indexPath.row] as! String
        self.present(controller, animated: true, completion: nil)
    }
    
}
