//
//  BagNumTableViewCell.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/16.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class BagNumTableViewCell: UITableViewCell {

    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var normalTextFiled: UITextField!
    @IBOutlet weak var desLable: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
