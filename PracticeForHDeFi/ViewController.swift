//
//  ViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/4/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KeychainSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
         print("AT VIEWDIDLOAD -----------------")
    }
    
    override func viewDidAppear(_ animated: Bool) {
         print("AT VIEWDIDAPPEAR -----------------")
        let keyChain = DataService().keyChain
        if keyChain.get("email") != nil {
            performSegue(withIdentifier: "SignIn", sender: nil)
        }
        print("AT END VIEWDIDAPPEAR -----------------")
    }
    
    func CompleteSignIn (id: String) {
        let keyChain = DataService().keyChain
        keyChain.set(id, forKey: "uid")
    }
 
    @IBAction func SignIn(_ sender: Any) {
        print("AT SIGN IN -----------------")
        if let email = emailField.text, let passwordL = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: passwordL) {
                (user, error) in
                if error == nil {
                    self.CompleteSignIn(id: user!.uid)
                    if (Auth.auth().currentUser?.isEmailVerified)! {
                        self.performSegue(withIdentifier: "SignIn", sender: self.emailField.text)
                    } else {
                        print("Can't sign in user.")
                        self.displayAlertMessage(messageToDisplay: "Can't sign in user.", yes: false)
                    }
                } else {
                    print("Can't sign in user.")
                    self.displayAlertMessage(messageToDisplay: "There is no current user with that email", yes: false)
                }
            }
        }
    }
    
    func displayAlertMessage(messageToDisplay: String, yes: Bool){
        var temp = ""
        if yes {
            temp += "Success"
        } else {
            temp += "Alert"
        }
        let alertController = UIAlertController(title: temp, message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action:UIAlertAction!) in
            
            print("Ok button tapped")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:  nil)
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: String) {
        if segue.identifier == "SignIn"
        {
            if let destinationVC = segue.destination as?  WelcomeViewController{
                destinationVC.email = emailField.text!
            }
        }
    }
}

