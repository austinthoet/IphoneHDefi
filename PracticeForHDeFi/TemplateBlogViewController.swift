//
//  TemplateBlogViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/13/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import os.log

class TemplateBlogViewController: UITableViewController{
    var posts = [Post]()
    var nameArray:[String] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
        loadPastBlogPosts()
       /*
        ref = ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            // ...
        })
        // Do any additional setup after loading the view.
         */
        if (Auth.auth().currentUser?.email?.compare("amt6062@psu.edu"))==ComparisonResult.orderedSame
        {
                navigationItem.leftBarButtonItem = editButtonItem
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        // Fetches the appropriate post for the data source layout.
        let post = posts[indexPath.row]
        
        cell.titleField.text = post.title
        cell.emailField.text = "Email: "+post.user.email!
        cell.dateField.text = "Date posted: " + post.date.description
        cell.descField.text = post.desc
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "addPost":
            os_log("Adding a new post.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let postDetailViewController = segue.destination as? MessagesViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedPostCell = sender as? TableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedPostCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPost = posts[indexPath.row]
            postDetailViewController.post = selectedPost
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }

    

    private func loadPastBlogPosts() {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        var theDate = formatter.string(from: currentDateTime)
        guard let post1 = Post(title: "Hey", desc: "What is going on right now? More specifically what do I have to do in your class to get a A", date: theDate, user: Auth.auth().currentUser!) else {
            fatalError("Unable to instantiate post")
        }
        posts += [post1]
        /*ref.child("Blog").observeSingleEvent(of: .value, with: { (snapshot) in
            if let blogPosts = snapshot.value {
                    for blogPost in blogPosts {
                        if let blogDict = blogA as? [String:Any] {
                            let title1 = blogDict["Title"] as? String
                            let description1 = blogDict["Description"] as? String
                            let date1 = blogDict["Date"] as? String
                            let email1 = blogDict["Email"] as? String
                            post1 = Post(title: title1, desc: description1, date: theDate, user: Auth.auth().currentUser!)
                            posts += [post1]
                        }
                    }
            }
        })*/
    }
        //ref.child("Blog").observeSingleEvent(of: .value, with: { (snapshot) in
            
           // let value = snapshot.value as? NSDictionary
            
            //let theTitle = value?["Week"] as? String ?? ""
            //let theText = value?["ReadingsText"] as? String ?? ""
            //self.readingsLabel.text = theTitle
            //self.readingsText.text = theText
        //})
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MessagesViewController, let post = sourceViewController.post {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                posts[selectedIndexPath.row] = post
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: posts.count, section: 0)
                
                posts.append(post)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
}
