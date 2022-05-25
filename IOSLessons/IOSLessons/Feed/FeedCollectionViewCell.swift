//
//  HomeCollectionViewCell.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelView: UILabel!
    @IBOutlet weak var likeControl: LikeControl!

    override func draw(_ rect: CGRect) {
//        var frame = imageView.frame;
//        imageView.contentMode = .scaleAspectFill
    }

    public func changeImages() {
//        let rect = imageView.frame
//        imageView.bounds = rect
        imageView.contentMode = .scaleAspectFill

//        imageView.frame = CGRect(x: -200.0, y: -200.0, width: rect.width+200, height: rect.height+200)
    }
}
