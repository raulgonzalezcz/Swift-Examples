//
//  ItemCell.swift
//  Aplicacion02
//
//  Created by UDLAP on 1/31/18.
//  Copyright © 2018 Udlap. All rights reserved.
//

import UIKit
class ItemCell:UITableViewCell{
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet var serialNumber: UILabel!
    
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumber.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
    
}
