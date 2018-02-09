//
//  ScheduleCell.swift
//  CSWSchool
//
//  Created by wyx on 2018/1/22.
//  Copyright © 2018年 com.cswSchool. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
