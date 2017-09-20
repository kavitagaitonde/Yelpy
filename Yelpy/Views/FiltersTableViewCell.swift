//
//  FiltersTableViewCell.swift
//  Yelpy
//
//  Created by Kavita Gaitonde on 9/19/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit

class FiltersTableViewCell: UITableViewCell {

    @IBOutlet weak var selectionSwitch: UISwitch!
    
    @IBOutlet weak var filterLabel: UILabel!
    
    var switchAction : (Bool) -> Void = { (isOn: Bool) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        switchAction(sender.isOn)
    }
    

}
