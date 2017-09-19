//
//  ReadingsViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/11/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase


class ReadingsViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var readingsLabel: UITextView!
    @IBOutlet weak var readingsText: UITextView!
    var doneButtonState: Bool!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //pull from database
        ref.child("Readings").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let theTitle = value?["Week"] as? String ?? ""
            let theText = value?["ReadingsText"] as? String ?? ""
            self.readingsLabel.text = theTitle
            self.readingsText.text = theText
            })
        doneButtonState = true
        readingsLabel.isUserInteractionEnabled = false
        readingsText.isUserInteractionEnabled = false
        if Auth.auth().currentUser?.email == "amt6062@psu.edu" {
            doneButton.isHidden = false
            doneButton.isUserInteractionEnabled = true
            print("GOT THE EMAIL CORRECT")
        } else {
            doneButton.isHidden = true
            doneButton.isUserInteractionEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func donePosting(_ sender: Any) {
        print("GOT TO DONE POSTING METHOD")
        if doneButtonState {
            doneButtonState = false
            print("GOT TO DONE POSTING METHOD TRUE")
            readingsLabel.isUserInteractionEnabled = true
            readingsText.isUserInteractionEnabled = true
            readingsLabel.isEditable = true
            readingsLabel.isSelectable = true
            readingsText.isEditable = true
            readingsText.isSelectable = true
            doneButton.setTitle("Done", for: .normal)
        } else {
            print("GOT TO DONE POSTING METHOD FALSE")
            doneButtonState = true
            readingsLabel.isUserInteractionEnabled = false
            readingsLabel.isEditable = false
            readingsLabel.isSelectable = false
            readingsText.isUserInteractionEnabled = false
            readingsText.isEditable = false
            readingsText.isSelectable = false
            self.ref.child("Readings").child("Week").setValue(readingsLabel.text)
            self.ref.child("Readings").child("ReadingsText").setValue(readingsText.text)
           doneButton.setTitle("Edit", for: .normal)
           
        }
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
