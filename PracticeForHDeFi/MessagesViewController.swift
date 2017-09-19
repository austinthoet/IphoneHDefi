//
//  MessagesViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/11/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import os.log

class MessagesViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var desc: UITextView!
    var post: Post?
    var ref: DatabaseReference!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        ref = Database.database().reference()
        print("CREATE VIEW DID LOAD")
        super.viewDidLoad()

        titleField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let post = post {
            navigationItem.title = post.title
            titleField.text = post.title
            desc.text = post.desc
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleField.setContentOffset(CGPoint.zero, animated: false)
        desc.setContentOffset(CGPoint.zero, animated: false)
    }
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //  @IBAction func addPost(_ sender: Any) {
     //   let uid: String = (Auth.auth().currentUser?.uid)!
        //Database.database().reference().child(uid).setValue(title: titleField.text, description: desc.text, date: Date, user: Auth.auth().currentUser)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancel(_ sender: UIBarButtonItem) {
            // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddPostMode = presentingViewController is UINavigationController
            
        if isPresentingInAddPostMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
                owningNavigationController.popViewController(animated: true)
        
        } else {
            fatalError("The PostViewController is not inside a navigation controller.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        let key = ref.child("Blog").childByAutoId().key
        let postz = ["Title": titleField.text,
                    "Email": Auth.auth().currentUser?.email,
                    "Description": desc.text,
                    "Date": formatter.string(from: currentDateTime)] as [String : Any]
        let childUpdates = ["/Blog/\(key)": postz]
                            //"/user_posts/\(Auth.auth().currentUser?.uid)/\(key)/": postz
        ref.updateChildValues(childUpdates)
        
        let title = titleField.text ?? ""
        let description = desc.text ?? ""
        let date = formatter.string(from: currentDateTime)
        let user = Auth.auth().currentUser
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        post = Post(title: title, desc: description, date: date, user: user!)
    }
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
