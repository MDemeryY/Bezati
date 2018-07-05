//
//  Charts.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/13/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import SwiftCharts
import UICircularProgressRing


class Charts: UIViewController , UICircularProgressRingDelegate , UITableViewDelegate , UITableViewDataSource{
    
    
    
    @IBOutlet weak var chartsStatics: UITableView!
    
    
    var chart:BarsChart?
    
    let chartConfig = BarsChartConfig(
        valsAxisConfig: ChartAxisConfig(from: 0, to: 800, by: 100)
    )
    
    @IBOutlet weak var chartView: UICircularProgressRingView!
    
    var data:[GoToNextData]?
    override func viewDidLoad() {
        
        self.chartsStatics.register(UINib.init(nibName: "chartViewCellTableViewCell" ,bundle : nil) , forCellReuseIdentifier: "chartCell")
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //self.convertDateIndexToDateString(index: 1)
        
        if Language.currentLanguage() == "en"{
            self.navigationItem.title = "Monthly Statistics"
            self.showHud("Loading...")
        }else{
            self.navigationItem.title = "الاحصائيات الشهرية"
            self.showHud("جار التحميل...")
        }
        
        
        AllRequset().goToNext { (result) in
            
            if result.count > 0 {
                self.data = result
                self.chartsStatics.delegate = self
                self.chartsStatics.dataSource = self
                self.chartsStatics.reloadData()
                self.hideHUD()
            }
            else{
                
                let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.chartsStatics.bounds.size.width, height: self.chartsStatics.bounds.size.height))
                noDataLabel.text          = "No data available"
                noDataLabel.textColor     = UIColor.black
                noDataLabel.textAlignment = .center
                self.chartsStatics.backgroundView  = noDataLabel
                self.chartsStatics.separatorStyle  = .none
                self.hideHUD()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.chartsStatics.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! chartViewCellTableViewCell
        //Begain Set Variables
        let money   = Double(data![indexPath.row].Money!)
        let budget  = Double(data![indexPath.row].Budget!)
        let rest    = budget - money
        let sum     = money + rest;
        //let x1      = CGFloat((money / sum) * 100);
        
        let x1  = (money/sum) * 100
        let x2      = ((rest / sum) * 100);
        
        
        //End Set Variables
        
                cell.restValue.text = "\(rest)"
                cell.ExpenceValue.text = "\(money)"
        
        cell.restPercent.text = "Rest" + "(" + "\(Int(x1))%" + ")"
        cell.expencePercent.text = "Expence" + "(" + "\(Int(x2))%" + ")"
        
        cell.titleLabel.text = "\(self.convertDateIndexToDateString(index: data![indexPath.row].Month!)) \(data![indexPath.row].Month!) / \(data![indexPath.row].Year!)"
        
        
        
        cell.ringView.setProgress(value: 0, animationDuration: 2) { [unowned self] in
            // Increase it more, and customize some properties
            //self.blueRingView.viewStyle = 4
            cell.ringView.setProgress(value:CGFloat(Int(x1)) , animationDuration: 3) {
                cell.ringView.font = UIFont.systemFont(ofSize: 15)
                print("Ring 2 finished")
            }
        }
        
        cell.blueRingView.setProgress(value: 0, animationDuration: 2) { [unowned self] in
            // Increase it more, and customize some properties
            //self.blueRingView.viewStyle = 4
            cell.blueRingView.setProgress(value:CGFloat(Int(x2)), animationDuration: 3) {
                cell.blueRingView.font = UIFont.systemFont(ofSize: 15)
                print("Ring 2 finished")
            }
        }
        
        //End Charts
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func convertDateIndexToDateString(index:Int) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        //print (dateFormatter.monthSymbols[0])
        return dateFormatter.monthSymbols[index-1]
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
