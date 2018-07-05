//
//  chartViewCellTableViewCell.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/24/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import UICircularProgressRing

class chartViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var ringView: UICircularProgressRingView!
    
    @IBOutlet weak var restValue: UILabel!
    
    @IBOutlet weak var ExpenceValue: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var blueRingView: UICircularProgressRingView!
    
    
    @IBOutlet weak var expencePercent: UILabel!
    
    
    @IBOutlet weak var restPercent: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
//        //Begain Charts
//        ringView.font =  UIFont.systemFont(ofSize: 20)
//        ringView.fontColor = UIColor.gray
//        blueRingView.font = UIFont.systemFont(ofSize: 20)
//        blueRingView.fontColor = UIColor.gray
//        ringView.animationStyle = kCAMediaTimingFunctionLinear
//        ringView.setProgress(value: -10, animationDuration: 5, completion: nil)
//        
//        blueRingView.setProgress(value: 0, animationDuration: 2) { [unowned self] in
//            // Increase it more, and customize some properties
//            //self.blueRingView.viewStyle = 4
//            self.blueRingView.setProgress(value: 20, animationDuration: 3) {
//                self.blueRingView.font = UIFont.systemFont(ofSize: 20)
//                print("Ring 2 finished")
//            }
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
