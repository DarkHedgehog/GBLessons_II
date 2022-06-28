//
//  ProfileViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 18.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {



    @IBOutlet weak var avatar: Avatar!
    @IBOutlet weak var groupsTable: UITableView!
    @IBOutlet weak var profileText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTable.dataSource = self
        profileText.text = StoredDataSourse.instance.profile.fullname
        avatar.imageUrl = StoredDataSourse.instance.profile.imageURL
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let profile = StoredDataSourse.instance.profile
        return profile.groupIds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCells", for: indexPath) as? ProfileTableViewCell else {
            preconditionFailure("Error cast to GroupTableViewCell")
        }

        let profile = StoredDataSourse.instance.profile
        let availableGroups = ApiDataService.instance.getAvailableGroups()
        guard let group = availableGroups.first(where: {$0.id == profile.groupIds[indexPath.row]}) else {
            cell.label.text = "unknown group"
            return cell
        }
        cell.picture.image = group.image
        cell.label.text = group.name

        return cell
    }

}
