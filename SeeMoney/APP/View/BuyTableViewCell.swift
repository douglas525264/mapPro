//
//  BuyTableViewCell.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/17.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class BuyTableViewCell: UITableViewCell {

    @IBOutlet weak var moneyLable: UILabel!
    @IBOutlet weak var payBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
