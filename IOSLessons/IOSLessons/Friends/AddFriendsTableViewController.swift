//
//  AddFriendsTableViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 25.05.2022.
//

import UIKit

class AddFriendsTableViewController: UITableViewController {

    @IBOutlet weak var friendsSearchBar: UISearchBar! {
        didSet {
            friendsSearchBar.delegate = self
        }
    }

    var sortesPersons = [Character:[Profile]]()
    var sortedKeys = [Character]()
    var filteredPersons = [Profile]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")

        filteredPersons = ApiDataService.instance.getUsers()

        updateSortedPersons()
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func updateSortedPersons() {
        sortesPersons =  [Character:[Profile]]()
        for persona in filteredPersons {
            guard let firstCharacter = persona.fullname.first else { continue }

            if sortesPersons[firstCharacter] == nil {
                sortesPersons[firstCharacter] = [persona]
            } else {
                sortesPersons[firstCharacter]?.append(persona)
            }
        }
        sortedKeys = sortesPersons.keys.sorted()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedKeys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let record = sortesPersons[sortedKeys[section]] else { return 0 }

        return record.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(sortedKeys[section])"
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell else {
            preconditionFailure("Error cast to FriendTableViewCell")
        }

        let keyCharacter = sortedKeys[indexPath.section]

        guard let user = sortesPersons[keyCharacter]?[indexPath.row] else {
            cell.labelView.text = "unknown persona"
            return cell
        }

        cell.labelView.text = user.fullname

        if let imageUrlString = user.imageURL,
           let imageUrl = URL(string: imageUrlString) {
            cell.pictureView.kf.setImage(with: imageUrl)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddSelectedFriends", sender: self)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddFriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            filteredPersons = ApiDataService.instance.getUsers()
        } else {
            filteredPersons = ApiDataService.instance.getUsers().filter  {
                $0.fullname.lowercased().contains(searchText.lowercased())
            }
        }
        updateSortedPersons()
        tableView.reloadData()
    }
}
