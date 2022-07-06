//
//  HomeCollectionViewCollectionViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import UIKit



class FeedCollectionViewController: UICollectionViewController {

    var posts = [UserPost]()

    var userId: Int? {
        didSet {
//            guard let personId = personId else { return }
//            posts = ApiDataService.instance.getPosts(userId: personId)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userId = userId else { return }

        RealmController.instance.getFriendPosts(userId: userId) { posts in
            guard let posts = posts else { return }
            self.posts = posts
                self.collectionView.reloadData()
        }
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Register cell classes
//        //        self.collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as? FeedCollectionViewCell else {
            preconditionFailure("Error cast to FeedCollectionViewCell")
        }

        cell.labelView.text = posts[indexPath.row].text

        cell.likeControl.isLiked = posts[indexPath.row].isLiked
        cell.likeControl.likeCount = posts[indexPath.row].likeCount
        cell.backgroundColor = .lightGray

        cell.imagesView.loadImagesNamed(posts[indexPath.row].imageUrls)
        cell.imagesView.delegate = cell

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        guard let FullScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullScreenImageViewController") as? FullScreenImageViewController else { return }
//
//        guard let cellTapped = collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell else { return }
//
//
//
////        FullScreenVC.setStartFrame(view.convert(cellTapped.imageView.frame, from: cellTapped))
//        FullScreenVC.setStartFrame(view.convert(cellTapped.imagesView.frame, from: cellTapped))
//        FullScreenVC.setImagesCollection(personsData[indexPath.row].postImageNames)
//        FullScreenVC.transitioningDelegate = FullScreenVC
//        FullScreenVC.modalPresentationStyle = .custom
////        FullScreenVC.modalPresentationStyle = .fullScreen
//
//        self.present(FullScreenVC, animated: true)
//        self.navigationController?.pushViewController(FullScreenVC, animated: true)
    }

}
