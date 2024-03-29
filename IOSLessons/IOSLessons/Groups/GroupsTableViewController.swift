//
//  GroupsTableViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 18.05.2022.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    let availableGroups = ApiDataService.instance.getAvailableGroups()
    var currentUser = ApiDataService.instance.getCurrentUser()

    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
        if let source = segue.source as? AllGroupsTableViewController,
           let indexPath = source.tableView.indexPathForSelectedRow {
            let group = availableGroups[indexPath.row]
            let groupId = group.id
            currentUser.groupIds.append(groupId)
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentUser.groupIds.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as? GroupTableViewCell else {
            preconditionFailure("Error cast to GroupTableViewCell")
        }

        guard let group = availableGroups.first(where: {$0.id == currentUser.groupIds[indexPath.row]}) else {
            cell.nameLabel.text = "unknown group"
            return cell
        }

        cell.picture.image = group.image
        cell.nameLabel.text = group.name
        cell.descriptionLabel.text = group.description

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let groupId = currentUser.groupIds[indexPath.row]
            currentUser.groupIds.removeAll(where: {$0 == groupId })
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
