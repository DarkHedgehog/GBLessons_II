//
//  TableTableViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 03.05.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiDataService.instance.getCurrentUser().friendsIds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell else {
            preconditionFailure("Error cast to FriendTableViewCell")
        }

        let api = ApiDataService.instance
        guard let friend = api.getUsers().first(where: {$0.id == api.getCurrentUser().friendsIds[indexPath.row]}) else {
            cell.labelView.text = "unknown persona"
            return cell
        }

        cell.labelView.text = friend.fullname
        cell.pictureView.image = friend.image
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
            let currentUser = ApiDataService.instance.getCurrentUser()
            guard let friend = ApiDataService.instance.getUsers().first(where: {$0.id == currentUser.friendsIds[indexPath.row]}) else {
                return
            }
            destination.title = friend.fullname
            destination.personId = friend.id
        }
    }


}
