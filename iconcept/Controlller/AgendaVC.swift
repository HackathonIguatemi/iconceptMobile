//
//  AgendaVC.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class AgendaVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {


    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var personalTbl: UITableView!
    @IBOutlet weak var eventoTbl: UITableView!
    
    var personal = [Personal]()
    var evento = [Eventos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        personalTbl.delegate = self
        personalTbl.dataSource = self
        
        eventoTbl.delegate = self
        eventoTbl.dataSource = self
        
        evento.removeAll()
        DataService.ds.REF_USER_EVENTO.observe(.value, with: { (snapshot2) in
            if let snapshot2 = snapshot2.children.allObjects as? [DataSnapshot] {
                for snap2 in snapshot2 {
                    if let postDict2 = snap2.value as? Dictionary<String, AnyObject> {
                        let key = snap2.key
                        let post = Eventos(postKey: key, postData: postDict2)
                        self.evento.append(post)
                    }
                }
            }
            self.eventoTbl.reloadData()
        })
        
        let user = Auth.auth().currentUser
        tituloLbl.text = "Experiências incriveís estarão à sua espera, \(user!.displayName as!String)."
        
        personalTbl.isHidden = true
        eventoTbl.isHidden = false
//        CarregaEventos()
        
//        eventoTbl.reloadData()
    }
    

    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            personalTbl.isHidden = true
            eventoTbl.isHidden = false
            let user = Auth.auth().currentUser
            tituloLbl.text = "Experiências incriveís estarão à sua espera, \(user!.displayName as!String)."

            CarregaEventos()
        case 1:
            personalTbl.isHidden = false
            eventoTbl.isHidden = true
            tituloLbl.text = "Consultoria com atendimento exclusivo à sua disposição"
            carregaPersonal()

        default:
            break
        }

    }

    func CarregaEventos () {
        evento.removeAll()
        DataService.ds.REF_USER_EVENTO.observe(.value, with: { (snapshot2) in
            if let snapshot2 = snapshot2.children.allObjects as? [DataSnapshot] {
                for snap2 in snapshot2 {
                    if let postDict2 = snap2.value as? Dictionary<String, AnyObject> {
                        let key = snap2.key
                        let post = Eventos(postKey: key, postData: postDict2)
                        self.evento.append(post)
                    }
                }
            }
            self.eventoTbl.reloadData()
        })
    }
    
    func carregaPersonal () {
        personal.removeAll()
        DataService.ds.REF_USER_PERSONA.observe(.value, with: { (snapshot2) in
            if let snapshot2 = snapshot2.children.allObjects as? [DataSnapshot] {
                for snap2 in snapshot2 {
                    if let postDict2 = snap2.value as? Dictionary<String, AnyObject> {
                        let key = snap2.key
                        let post = Personal(postKey: key, postData: postDict2)
                        self.personal.append(post)
                    }
                }
            }
            self.personalTbl.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var retorno = 0
        if eventoTbl.isHidden == false {
            retorno = personal.count
        } else {
            retorno = evento.count
        }
        
        return retorno
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if eventoTbl.isHidden == true {
            let persona = personal[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? AgendaTVC {
                cell.configureCell(personal: persona)
                return cell
            }
            return AgendaTVC()
        } else {
            let event = evento[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? eventosTVC {
                cell.configureCell(evento: event)
                return cell
            }
            return eventosTVC()
        }
    }
}
