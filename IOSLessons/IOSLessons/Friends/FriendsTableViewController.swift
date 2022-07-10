//
//  TableTableViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 03.05.2022.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {

    var groupIds: [String] = []

    var friends: [User] = []
    var usersNotificationToken: NotificationToken?

    @IBAction func addSelectedFriends(segue: UIStoryboardSegue) {
        if let source = segue.source as? AddFriendsTableViewController,
           let indexPath = source.tableView.indexPathForSelectedRow,
           let friend = source.sortesPersons[source.sortedKeys[indexPath.section]]?[indexPath.row]
        {

            let friendId = friend.id
            ApiDataService.instance.addFriend(id: friendId);

            tableView.reloadData()
        }
    }

    deinit {
        usersNotificationToken?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")

        usersNotificationToken = RealmController.instance.getFriendsSubscription { change in
            switch change {
            case .initial(let dbUsers):
                self.friends = dbUsers.map { $0.toModel() }
                self.tableView.reloadData()
            case .update(let dbUsers, let deletions, let insertions, let modifications):
                self.friends = dbUsers.map { $0.toModel() }
                self.tableView.performBatchUpdates {
                    self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0)}, with: .middle)
                    self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0)}, with: .middle)
                    self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0)}, with: .middle)
                }
                self.tableView.reloadData()
            case .error:
                break
            }
        }



//        RealmController.instance.getFriends { friends in
//            guard let friends = friends else { return }
//            self.friends = friends
//            DispatchQueue.main.async() {
//                self.tableView.reloadData()
//            }
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell else {
            preconditionFailure("Error cast to FriendTableViewCell")
        }

        let friend = friends[indexPath.row]

        cell.labelView.text = friend.fullname

        if let imageUrlString = friend.imageURL,
           let imageUrl = URL(string: imageUrlString) {
            cell.pictureView.kf.setImage(with: imageUrl)
        }

//        cell.inputViewController?.performSegue(withIdentifier: "showHomeCollection", sender: tableView)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showHomeCollection", sender: tableView)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showHomeCollection",
           let destination = segue.destination as? FeedCollectionViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let currentUser = CurrentProfile.instance.profile
            let friend = friends[indexPath.row]

            destination.title = friend.fullname
            destination.userId = friend.id
        }
    }


}
