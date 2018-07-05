//
//  ExpectViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/6/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit

class ExpectViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var expectTableView: UITableView!
    
    var data:[GoToNextData]?
    
    override func viewDidLoad() {
        self.expectTableView.register(UINib.init(nibName: "ExpectViewCell" ,bundle : nil) , forCellReuseIdentifier: "ExpectViewCell")
        self.hideKeyboardWhenTappedAround() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Language.currentLanguage() == "en" {
            showHud("Loading...")
            self.navigationController?.navigationBar.topItem?.title = "Expected"
        }else{
            showHud("جار التحميل...")
            self.navigationController?.navigationBar.topItem?.title = "المتوقع"
        }
        let date = NSDate()
        let calaender = NSCalendar.current
        let month = calaender.component(.month, from: date as Date)
        
        if Language.currentLanguage() == "en" {
            self.showHud("Loading...")
        }else{
            self.showHud("جار التحميل...")
        }
        AllRequset().goToNextwithMonth(month: month) { (result) in
            print(result.count)
            if result.count > 0{
                self.data = result
                self.expectTableView.delegate = self
                self.expectTableView.dataSource = self
                self.expectTableView.reloadData()
                self.hideHUD()
            }
            else{
                let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.expectTableView.bounds.size.width, height: self.expectTableView.bounds.size.height))
                noDataLabel.text          = "No data available"
                noDataLabel.textColor     = UIColor.black
                noDataLabel.textAlignment = .center
                self.expectTableView.backgroundView  = noDataLabel
                self.expectTableView.separatorStyle  = .none
                self.hideHUD()
            }
            self.hideHUD()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  (self.data?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.expectTableView.dequeueReusableCell(withIdentifier: "ExpectViewCell", for: indexPath) as! ExpectViewCell
        
        cell.targetValue.text = "\(self.data![indexPath.row].Budget!)"
        cell.expenceValue.text = "\(self.data![indexPath.row].Money!)"
        cell.percentageValue.text = "\(calculatePercentageValue(target: self.data![indexPath.row].Budget!, expence: self.data![indexPath.row].Money!)) %"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    
    func calculatePercentageValue(target:Int , expence:Int) -> Int{
        return (target - expence) / target * 100
    }
    
}
