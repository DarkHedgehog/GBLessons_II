//
//  HomeCellTableViewCell.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet var labelView: UILabel!
    @IBOutlet var pictureView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
