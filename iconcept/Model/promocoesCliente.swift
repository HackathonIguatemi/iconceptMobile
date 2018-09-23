//
//  promocoesClinete.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class PromocoesCliente {
    
    private var _data : String!
    private var _item : String!
    private var _loja : String!
    private var _valor : Double!
    private var _postKey: String!
    private var _postRef: DatabaseReference!

    
    var data : String {
        return _data
    }
    
    var item : String {
        return _item
    }
    
    var loja : String {
        return _loja
    }
    
    var valor : Double {
        return _valor
    }
    
    init (postKey: String,  postData: Dictionary<String, AnyObject> ) {
        self._postKey = postKey
        
        if let data = postData["data"] as? String {
            self._data = data
        }
        
        if let item = postData["item"] as? String {
            self._item = item
        }
        
        if let loja = postData["loja"] as? String {
            self._loja = loja
        }
        
        if let valor = postData["valor"] as? Double {
            self._valor = valor
        }
        
        
        _postRef = DataService.ds.REF_USERS.child("promocoes").child(_postKey)
        
    }
}
