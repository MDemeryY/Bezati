//
//  DayItemsViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/11/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit

class DayItemsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var selectedDay:Int?
    
    var items:[ItemData]?
    
    @IBOutlet weak var dateChooseTableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.dateChooseTableView.register(UINib.init(nibName: "ItemManageViewCell" ,bundle : nil) , forCellReuseIdentifier: "itemManageViewCell")
        self.hideKeyboardWhenTappedAround() 
        
    }
    
    
    
    @objc func notificationRecevied(notification: Notification) {
        print("Addeded")
        self.alert(message: "Save Changes is Success", title: "Success")
        viewWillAppear(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Language.currentLanguage() == "en"{
           
            self.navigationItem.title = "Items"
            self.showHud("Loading...")
        }else{
            self.navigationItem.title = "العناصر"
            self.showHud("Loading...")
        }
        AllRequset().getItemManage(day: selectedDay!, accessToken: HandleToken.token) { (result) in
            self.items = result
            self.dateChooseTableView.delegate = self
            self.dateChooseTableView.dataSource = self
            self.dateChooseTableView.reloadData()
            self.hideHUD()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.dateChooseTableView.dequeueReusableCell(withIdentifier: "itemManageViewCell", for: indexPath) as! ItemManageViewCell
        
        cell.itemNameLabel.text = self.items![indexPath.row].name
        cell.priceLabel.text = "\( String(describing: self.items![indexPath.row].price!))"
        
        cell.categoryLabel.text = self.items![indexPath.row].incomeCategoryName
        cell.notesLabel.text = self.items![indexPath.row].notes
        
        //delegate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}
