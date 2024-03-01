//
//  ListTableViewCell.swift
//  Mindteck
//
//  Created by HYTML00001 on 28/02/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var listImge: UIImageView!
    @IBOutlet var backView: UIView!
    @IBOutlet var  nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backView.layer.cornerRadius = 2
//        backView.layer.borderWidth = 1
//        backView.layer.borderColor = UIColor.gray.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
