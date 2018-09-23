//
//  promocoes.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class Promocoes {
    
    private var _nome : String!
    private var _URL : String!
    private var _descricao : String!
    private var _local : String!
    private var _data : String!
    private var _postKey: String!
    private var _postRef: DatabaseReference!
    
    var nome : String {
        return _nome
    }
    
    var URL : String {
        return _URL
    }
    
    var descricao : String {
        return _descricao
    }
    
    var local : String {
        return _local
    }
    
    var data : String {
        return _data
    }
    
    init (postKey: String,  postData: Dictionary<String, AnyObject> ) {
        self._postKey = postKey
        
        if let nome = postData["nome"] as? String {
            self._nome = nome
        }
        
        if let URL = postData["URL"] as? String {
            self._URL = URL
        }
       
        if let descricao = postData["descricao"] as? String {
            self._descricao = descricao
        }
        
        if let local = postData["local"] as? String {
            self._local = local
        }
        
        if let data = postData["data"] as? String {
            self._data = data
        }
        
        _postRef = DataService.ds.REF_PROMOCAO.child(_postKey)
        
    }
}
