//
//  eventos.swift
//  iconcept
//
//  Created by Carlos Doki on 23/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class Eventos {
    
    private var _postKey: String!
    private var _postRef: DatabaseReference!
    private var _data : String!
    private var _key : String!

   
    var key : String {
        return _key 
    }
    
    init (postKey: String,  postData: Dictionary<String, AnyObject> ) {
        self._postKey = postKey
        
        if let key = postKey as? String {
            self._key = key
        }
        
        if let data = postData["data"] as? String {
            self._data = data
        }
        
        _postRef = DataService.ds.REF_USERS.child("eventos").child(_postKey)
        
    }
}
