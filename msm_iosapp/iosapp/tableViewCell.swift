//
//  tableViewCell.swift
//  iosapp
//
//  Created by 徐梓修 on 2020/7/28.
//  Copyright © 2020 徐梓修. All rights reserved.
//

import UIKit

class tableViewCell: UITableViewCell{
    var actionBlock: (()->Void)? = nil
    
    @IBOutlet weak var id_label: UILabel!
    //@IBOutlet weak var position_label: UILabel!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var status_label: UILabel!
    @IBOutlet weak var reason_button: UIButton!
    @IBOutlet weak var submit_date: UILabel!
    @IBOutlet weak var submit_time: UILabel!
    @IBAction func didTapButton(_ sender: Any) {
        actionBlock?()
    }
}
