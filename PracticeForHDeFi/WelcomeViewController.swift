//
//  WelcomeViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/13/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class WelcomeViewController: UIViewController {
    var email = ""
    @IBOutlet weak var welcomeText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeText.text = "Welcome, \(email)!"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueButton(_ sender: Any) {
        performSegue(withIdentifier: "continueSeg", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
