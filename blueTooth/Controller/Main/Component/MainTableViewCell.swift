//
//  MainTableViewCell.swift
//  blueTooth
//
//  Created by imac-1682 on 2023/8/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var Service: UILabel!
    static let identifier = "MainTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
