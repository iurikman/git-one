//
//  FriendsTableViewController.swift
//  Womework1_Kutyrev
//
//  Created by Yuriy Kutyrev on 09.02.2019.
//  Copyright © 2019 Yuriy Kutyrev. All rights reserved.
//

import UIKit


    


class FriendsTableViewController: UITableViewController {

    var friends: [Friend] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell

        let friend = self.friends[indexPath.row]
        cell.setFriend(friend: friend)

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
            self.friends.remove(at: indexPath.row)
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addFriend", let dest = segue.destination as? AddFriendTableViewController {
            dest.delegate = self
        } else if segue.identifier == "openFriend", let dest = segue.destination as? FriendCollectionViewController {
            dest.friend = self.friends[self.tableView.indexPathForSelectedRow!.row]
                }
   }
}

extension FriendsTableViewController: AddFriendDelegate {
    
    func addFriend(friend: Friend) {
        print("addFriend \(String(describing: friend.name))")
        
        var containts = false
        for friendInVC in self.friends {
            if friend.name == friendInVC.name {
                containts = true
                break
            }
        }
        
        if false == containts {
            self.friends.append(friend)
            self.tableView.reloadData()
        }
    }
}
