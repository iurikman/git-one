//
//  AddFriendTableViewCell.swift
//  Womework1_Kutyrev
//
//  Created by Yuriy Kutyrev on 09.02.2019.
//  Copyright © 2019 Yuriy Kutyrev. All rights reserved.
//

import UIKit

class AddFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendNameLabel: UILabel?
    
    func setFriend(friend: Friend) {
        self.friendNameLabel?.text = friend.name
    }
    

}
