//
//  GroupsTableViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 18.05.2022.
//

import UIKit

class GroupsTableViewController: UITableViewController {

//    let availableGroups = ApiDataService.instance.getAvailableGroups()

//    var currentUser = StoredDataSourse.instance.profile

    var groups = [Group]()

    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
        if let source = segue.source as? AllGroupsTableViewController,
           let indexPath = source.tableView.indexPathForSelectedRow {
            if let groupId = source.tableView.cellForRow(at: indexPath)?.tag {
                ApiDataService.instance.addGroup(groupId) { _ in
                    self.updateGroups()
                }
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateGroups()
    }


    private func updateGroups () {
        ApiDataService.instance.getProfileGroups() { groups in
            guard let groups = groups else { return }

            self.groups = groups
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as? GroupTableViewCell else {
            preconditionFailure("Error cast to GroupTableViewCell")
        }

        let group = groups[indexPath.row]

        if let imageUrlString = group.imageURL,
           let imageUrl = URL(string: imageUrlString) {
            cell.picture.kf.setImage(with: imageUrl)
        }

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
            let groupId = groups[indexPath.row].id

            ApiDataService.instance.leaveGroup(groupId) { _ in
//                self.updateGroups()
                DispatchQueue.main.async() {
                    self.groups.removeAll(where: {$0.id == groupId })
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }


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
