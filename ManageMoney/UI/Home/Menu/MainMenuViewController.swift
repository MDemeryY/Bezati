//
//  MainViewController.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-01.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import Alamofire
class MainMenuViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    var menuItem = ["My Account","Category","Expected","Monthly Statistics","Calendar","Choose Date","Settings","Logout"]
    
    let englishMenu =  ["My Account","Category","Expected","Monthly Statistics","Calendar","Choose Date","Settings","Logout"]
    
    let arabicMenu = ["الحساب","الفئة","المتوقع","الحسابات الشهريه","التقويم","اختار موعدا","الاعدادات","الخروج"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        if Language.currentLanguage() == "ar-EG"{
            menuItem = arabicMenu
        }
    }
    
       override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
} 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        
        let cell:UITableViewCell = self.menuTableView.dequeueReusableCell(withIdentifier: "MenuCell") as UITableViewCell!
        
        cell.textLabel?.text = menuItem[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.textLabel?.textColor = #colorLiteral(red: 0.3555280566, green: 0.784229815, blue: 0.865256846, alpha: 1)
        //category
        switch(indexPath.row){
        case 0:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Myaccount", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MyAccount") as! MyAccountViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            break
            
        case 1:
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Category", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "category") as! CategoryViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            break
            
        
        case 2:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Expect", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "expect") as! ExpectViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            break
            
        case 3:
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Chart", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "chart") as! Charts
            self.navigationController?.pushViewController(resultViewController, animated: true)
            break
            
            
        case 4:
            let storyBoard : UIStoryboard = UIStoryboard(name: "MenuCalendar", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MenuCalendar") as! MenuCalendar
            self.navigationController?.pushViewController(resultViewController, animated: true)
            break
        case 5:
            let storyBoard : UIStoryboard = UIStoryboard(name: "MenuChooseDate", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MenuChooseDate") as! MenuChooseDate
            self.navigationController?.pushViewController(resultViewController, animated: true)
            break
        case 6:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Settings", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            break
        case 7:
            
            HandleToken.removeToken(key: "AccessToken")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Login", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! Login
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
            resultViewController.navigationController?.navigationBar.isHidden = true
            break
            
        default:
            break
        }
    }
}

