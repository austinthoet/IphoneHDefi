//
//  SignOutCode.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/5/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class SignOutCode: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func SignOut (_ sender: Any){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        KeychainSwift().delete("uid")
        dismiss(animated: true, completion: nil)
    }
}
