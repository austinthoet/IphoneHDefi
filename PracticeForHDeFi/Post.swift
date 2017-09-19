//
//  File.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/14/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import Foundation
import FirebaseAuth

class Post {
    
    
    var title: String
    var desc: String
    var date: String
    var user: User
    
    //MARK: Initialization
    
    init?(title: String, desc: String, date: String, user: User) {
        
        guard !title.isEmpty else {
            return nil
        }
        
        guard !desc.isEmpty else {
            return nil
        }

        
        // Initialize stored properties.
        self.title = title
        self.desc = desc
        self.date = date
        self.user = user
        
    }

    
    
    
}
