//
//  DataService.swift
//  FideliCash-Cliente
//
//  Created by Carlos Doki on 09/06/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    static let ds = DataService()
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_HISTORY = DB_BASE.child("history")
    private var _REF_PREFERENCIAS = DB_BASE.child("preferencias")
    private var _REF_PROMOCAO = DB_BASE.child("promocoes")

    private var _REF_POST_IMAGES=STORAGE_BASE.child("preferencias")

    
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_HISTORY: DatabaseReference {
        return _REF_HISTORY
    }
    
    var REF_PREFERENCIAS: DatabaseReference {
        return _REF_PREFERENCIAS
    }
    
    var REF_PROMOCAO: DatabaseReference {
        return _REF_PROMOCAO
    }
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_USER_PERSONA: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!).child("personal")
        return user
    }
    
    var REF_USER_EVENTO: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!).child("eventos")
        return user
    }
}
