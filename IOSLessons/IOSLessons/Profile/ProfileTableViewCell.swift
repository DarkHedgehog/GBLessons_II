//
//  GroupTableCellViewTableViewCell.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 18.05.2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
