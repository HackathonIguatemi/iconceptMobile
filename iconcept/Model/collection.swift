//
//  collection.swift
//  iconcept
//
//  Created by Carlos Doki on 22/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Alamofire

class Collection {
    private var _collectionId : Int!
    private var _collectionURL : String!
    
    var collectionId: Int {
        if _collectionId == nil {
            _collectionId = 0
        }
        return _collectionId
    }
    
    var collectionURL : String {
        if _collectionURL == nil {
            _collectionURL = ""
        }
        return _collectionURL
    }
}
