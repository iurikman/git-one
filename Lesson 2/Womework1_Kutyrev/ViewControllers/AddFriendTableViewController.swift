//
//  CitiesTableViewController.swift
//  Womework1_Kutyrev
//
//  Created by Yuriy Kutyrev on 02.02.2019.
//  Copyright © 2019 Yuriy Kutyrev. All rights reserved.
//

import UIKit

protocol AddFriendDelegate: class {
    func addFriend(friend: Friend)
}

class AddFriendTableViewController: UITableViewController {
    
    
    weak var delegate: AddFriendDelegate?
    
    private var friends: [Friend] = []
    var filteredFriends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let names = ["Даша", "Юра", "Миша", "Серега", "Гошан", "Леха"]
        for name in names {
            let friend = Friend()
            friend.name = name
            
            self.friends.append(friend)
           
        }
        
        self.filter(query: "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filteredFriends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendTableViewCell", for: indexPath) as!
        AddFriendTableViewCell
        
        let friend = self.filteredFriends[indexPath.row]
        cell.setFriend(friend: friend)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        
        let friend = self.filteredFriends[indexPath.row]
        self.delegate?.addFriend(friend: friend)
    }
    
    func filter(query: String) {
        self.filteredFriends.removeAll()
        
        for friend in self.friends {
            
            guard let name = friend.name else {
                continue
            }
            
            var isInFilter = true
            
            if query.count > 0 {
                isInFilter = name.lowercased().contains(query.lowercased())
            }
            
            if isInFilter {
                self.filteredFriends.append(friend)
            }
        }
        
        self.tableView.reloadData()
    }
}

extension AddFriendTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchBar textDidChange \(searchText)")
        self.filter(query: searchText)
    }
}
