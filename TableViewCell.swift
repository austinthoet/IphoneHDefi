//
//  TableViewCell.swift
//  PracticeForHDeFi
//
//  Created by Austin Thoet on 9/14/17.
//  Copyright © 2017 Austin Thoet. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
