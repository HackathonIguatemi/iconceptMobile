//
//  personal.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class Personal {
    private var _consultor : String!
    private var _data : String!
    private var _horainicial : String!
    private var _horafinal : String!
    private var _local : String!
    private var _postKey: String!
    private var _postRef: DatabaseReference!
    
    var consultor : String {
        return _consultor
    }
    
    var data : String {
        return _data
    }
    
    var horainicial : String {
        return _horainicial
    }
    
    var horafinal : String {
        return _horafinal
    }
    
    var local: String {
        return _local
    }
    
    
    init (postKey: String,  postData: Dictionary<String, AnyObject> ) {
        self._postKey = postKey
        
        if let data = postData["data"] as? String {
            self._data = data
        }
        
        if let consultor = postData["consultor"] as? String {
            self._consultor = consultor
        }
        
        if let horainicial = postData["horainicial"] as? String {
            self._horainicial = horainicial
        }
        
        if let horafinal = postData["horafinal"] as? String {
            self._horafinal = horafinal
        }

        if let local = postData["local"] as? String {
            self._local = local
        }

        
        _postRef = DataService.ds.REF_USERS.child("personal").child(_postKey)
        
    }
}
