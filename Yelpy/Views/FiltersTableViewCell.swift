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
    
    @IBOutlet weak var switchOffImageView: UIImageView!
    @IBOutlet weak var switchImageView: UIImageView!
    
    @IBOutlet weak var switchOnImageView: UIImageView!
    @IBOutlet weak var switchOffLabel: UILabel!
    @IBOutlet weak var switchOnLabel: UILabel!

    var switchAction : (Bool) -> Void = { (isOn: Bool) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5;
        self.switchOnImageView.isHidden = true
        self.switchOnLabel.isHidden = true
        self.switchOffImageView.isHidden = false
        self.switchOffLabel.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSwitchImages() {
        if(self.selectionSwitch.isHidden) {
            self.switchOnImageView.isHidden = true
            self.switchOnLabel.isHidden = true
            self.switchOffImageView.isHidden = true
            self.switchOffLabel.isHidden = true
        }else if(self.selectionSwitch.isOn) {
            self.switchOnImageView.isHidden = false
            self.switchOnLabel.isHidden = false
            self.switchOffImageView.isHidden = true
            self.switchOffLabel.isHidden = true
        } else {
            self.switchOnImageView.isHidden = true
            self.switchOnLabel.isHidden = true
            self.switchOffImageView.isHidden = false
            self.switchOffLabel.isHidden = false
        }
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        setupSwitchImages()
        switchAction(sender.isOn)
    }
    

}
