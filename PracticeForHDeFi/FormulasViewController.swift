//
//  FormulasViewController.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/11/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit

class FormulasViewController: UIViewController {

    @IBOutlet weak var thisPage: UIImageView!
    @IBOutlet weak var pageNumber: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        thisPage.image = #imageLiteral(resourceName: "formula2")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeToSecond(_ sender: UISwipeGestureRecognizer) {
        if(pageNumber.currentPage == 0){
            thisPage.image  = #imageLiteral(resourceName: "formula1")
            pageNumber.currentPage = 1
            }
    }

    @IBAction func swipeToFirst(_ sender: Any) {
        if(pageNumber.currentPage == 1){
            thisPage.image  = #imageLiteral(resourceName: "formula2")
            pageNumber.currentPage = 0
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
