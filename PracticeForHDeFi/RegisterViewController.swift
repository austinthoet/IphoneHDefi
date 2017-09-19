//
//  RegisterViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/12/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        print("MADE VIEW DID LOAD REGISTER")
        super.viewDidLoad()
        print("MADE VIEW DID LOAD REGISTER END")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        print("AT SIGN UP -----------------")
        //let email = emailField.text
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: emailField.text!)
        if isEmailAddressValid {
            if passwordField.text! == "" {
                displayAlertMessage(messageToDisplay: "Please enter a password.", yes: false)
                self.passwordField.text = ""
                self.repeatPassword.text = ""
            } else if !(passwordField.text == repeatPassword.text) {
                displayAlertMessage(messageToDisplay: "The passwords entered do not match.", yes: false)
                self.passwordField.text = ""
                self.repeatPassword.text = ""
            } else if passwordField.text!.characters.count < 6 {
                displayAlertMessage(messageToDisplay: "The password entered is not at least 6 characters long.", yes: false)
                self.passwordField.text = ""
                self.repeatPassword.text = ""
            } else {
                Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user:User?, error:Error?) in
                    if error != nil {
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                                
                                let post2 = UIAlertController(title: "Success", message: "A verification email was sent to your email. Please check your inbox and click on the link to be added to the class.", preferredStyle: .alert)
                                post2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                }))
                                self.present(post2, animated: true, completion: nil)
                            })
                        }
                    }
                }
            }
            self.emailField.text = ""
            self.passwordField.text = ""
            self.repeatPassword.text = ""
        } else {
            print("I am sorry but only students with Penn State email addresses may sign up.")
            self.displayAlertMessage(messageToDisplay: "I am sorry but only students with Penn State email addresses may sign up.", yes: false)
            self.passwordField.text = ""
            self.repeatPassword.text = ""
            
        }
        /* print("A verification email was sent to your email. Please check your inbox and click on the link to be added to the class." )
         displayAlertMessage(messageToDisplay: "A verification email was sent to your email. Please check your inbox and click on the link to be added to the class.", yes: true)
         Auth.auth().currentUser.sendEmailVerification(with: self.emailField.text!, completion: { (error) in
         
         var title = ""
         var message = ""
         
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         self.present(alertController, animated: true, completion: nil)
         })
         print("got past it")
         } else {
         print("I am sorry but only students with Penn State email addresses may sign up.")
         displayAlertMessage(messageToDisplay: "I am sorry but only students with Penn State email addresses may sign up.", yes: false)
         }*/
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backSignIn", sender: nil)
    }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        if returnValue == true {
            if emailAddressString.contains("@psu.edu") == false {
                returnValue = false
            }
        }
        return  returnValue
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
}
