//
//  HomeCell.swift
//  Money Management
//
//  Created by Eng Nour Hegazy on 3/24/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

  @IBOutlet weak var itemName : UILabel!
  @IBOutlet weak var itemPrice: UILabel!
  @IBOutlet weak var payment: UILabel!
@IBOutlet weak var note : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell (item : ItemData){
    self.itemName.text = item.name
    self.itemPrice.text = item.price?.description
   self.note.text = item.notes
    
    
  }

}
