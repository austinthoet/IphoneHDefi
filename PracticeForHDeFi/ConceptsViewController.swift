//
//  ConceptsViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/11/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class ConceptsViewController: UIViewController, UIScrollViewDelegate {
    
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = #imageLiteral(resourceName: "ConceptMap")
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    }
    
    
    
    /* @IBAction func zoomGesture(_ sender: UIPinchGestureRecognizer) {
        self.view.transform = self.view.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
