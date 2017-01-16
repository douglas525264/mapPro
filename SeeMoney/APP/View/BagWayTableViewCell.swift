//
//  BagWayTableViewCell.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/16.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class BagWayTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var contentScrollView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
