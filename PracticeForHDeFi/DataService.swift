//
//  DataService.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/5/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift
import FirebaseDatabase


let DB_BASE = Database.database().reference()

class DataService {
    private var _keyChain = KeychainSwift()
    private var _refDatabase = DB_BASE
    
    var keyChain: KeychainSwift {
        get {
            return _keyChain
        } set {
            _keyChain = newValue
        }
    }
}
