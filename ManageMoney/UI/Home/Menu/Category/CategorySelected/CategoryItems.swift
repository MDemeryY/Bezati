//
//  ItemByCategoryViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/12/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit

class ItemByCategoryViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource
{
    var catId:Int?
    var type:Int?
    var items:[ItemData]?
    
    
    @IBOutlet weak var categoryItemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
        self.categoryItemsTableView.register(UINib.init(nibName: "ItemManageViewCell" ,bundle : nil) , forCellReuseIdentifier: "itemManageViewCell")
        
    }
    
    @objc func notificationRecevied(notification: Notification) {
        print("Addeded")
        self.alert(message: "Save Changes is Success", title: "Success")
        viewWillAppear(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Language.currentLanguage() == "en" {
            self.navigationItem.title = "Items"
        }else{
            self.navigationItem.title = "العناصر"
        }
        self.showHud("Loading...")
        
        AllRequset().getItemCategory(id: self.catId!, accessToken: HandleToken.token) { (result) in
            if result.count > 0 {
                self.items = result
                self.categoryItemsTableView.delegate = self
                self.categoryItemsTableView.dataSource = self
                self.categoryItemsTableView.reloadData()
                self.hideHUD()
            }else{
                
                let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.categoryItemsTableView.bounds.size.width, height: self.categoryItemsTableView.bounds.size.height))
                noDataLabel.text          = "No data available"
                noDataLabel.textColor     = UIColor.black
                noDataLabel.textAlignment = .center
                self.categoryItemsTableView.backgroundView  = noDataLabel
                self.categoryItemsTableView.separatorStyle  = .none
                self.hideHUD()
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.items?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.categoryItemsTableView.dequeueReusableCell(withIdentifier: "itemManageViewCell", for: indexPath) as! ItemManageViewCell
        
        cell.itemNameLabel.text = self.items![indexPath.row].name
        cell.priceLabel.text = "\( String(describing: self.items![indexPath.row].price!))"
        
        cell.categoryLabel.text = self.items![indexPath.row].incomeCategoryName
        cell.notesLabel.text = self.items![indexPath.row].notes
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    
}
