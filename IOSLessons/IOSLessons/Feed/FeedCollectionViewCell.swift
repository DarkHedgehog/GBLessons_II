//
//  HomeCollectionViewCell.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imagesView: MultipleImagesView!
    @IBOutlet var labelView: UILabel!
    @IBOutlet weak var likeControl: LikeControl!

}

extension FeedCollectionViewCell: MultipleImagesViewDelegate {
    func tapOnImage(frame: CGRect) {
        guard let FullScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullScreenImageViewController") as? FullScreenImageViewController else { return }

        let absFrame = convert(frame, to: self.window?.rootViewController?.view)
        FullScreenVC.setStartFrame(absFrame)
        FullScreenVC.setImagesCollection(imagesView.imageUrls)
        FullScreenVC.transitioningDelegate = FullScreenVC
        FullScreenVC.modalPresentationStyle = .custom
        //        FullScreenVC.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(FullScreenVC, animated: true)

    }
}
