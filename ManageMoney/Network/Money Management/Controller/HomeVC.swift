//
//  HomeVC.swift
//  Money Management
//
//  Created by Eng Nour Hegazy on 3/24/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import PopupDialog
class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let allrequest = AllRequset()
    
    ////var accessKey :String = (UserDefaults.standard.object(forKey: "AccessToken") as? String)!
    var accsessToken = String()
    var menuarr = [" Daily","Calendar","Weakly","Monthly"]
    var mainMenuArr = [ItemData](){didSet{tableView.reloadData()}}
    
    var monthlyArr = [ItemData]()
    var dailyArr = [ItemData]()
    var WeaklyArr  = [ItemData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        allrequest.getItemManage(day: 0, accessToken: accsessToken) { (itemDataArr) in
            self.mainMenuArr = itemDataArr 
        }
        addItem.layer.cornerRadius = addItem.bounds.width/2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuarr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeMenuCell
        cell.sectionNam.text = menuarr[indexPath.row]
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.bounds.width/4-4  , height: self.view.bounds.width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
            
        case 0 :
            print("")
        case 1:
            print("")
        case 2 :
            print("")
        case 3 :
            print("")
        default:
            return
        }
        
    }
    
    // table View  Delegata And  Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  mainMenuArr.count  //mainMenuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        cell.configCell(item: mainMenuArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @IBAction func addItemBTn(_ sender: Any) {
        let popupAdditemVC  = addItemPopVC(nibName: "addItemPopVC", bundle: nil)
        let popup = PopupDialog(viewController: popupAdditemVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        self.present(popup, animated: true, completion: nil)
    }
    
}

