//
//  preferencias.swift
//  iconcept
//
//  Created by Carlos Doki on 22/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class Preferencias {
    private var _nome : String!
    private var _URL : String!
    private var _postKey: String!
    private var _postRef: DatabaseReference!
    
    var nome : String {
        return _nome
    }
    
    var URL : String {
        return _URL
    }
    
    init (postKey: String,  postData: Dictionary<String, AnyObject> ) {
        self._postKey = postKey
        
        if let nome = postData["nome"] as? String {
            self._nome = nome
        }
        
        if let URL = postData["URL"] as? String {
            self._URL = URL
        }
        
        _postRef = DataService.ds.REF_PREFERENCIAS.child(_postKey)
        
    }
}
