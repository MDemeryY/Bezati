//
//  CategoryViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/6/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import PopupDialog

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var expenseCollectionView: UICollectionView!
    
    @IBOutlet weak var incomeCollectionView: UICollectionView!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 20.0, bottom: 20.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 3
    
    var outCats:[CategoryData]?
    var incomeCats:[CategoryData]?
    
    var incomeNib = UINib(nibName: "IncomeCollectionViewCell", bundle:nil)
    
    var nib = UINib(nibName: "ExpenceViewCell", bundle:nil)
    
    var categoryId:Int?
    var categoryType:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.incomeCollectionView.register(incomeNib, forCellWithReuseIdentifier: "incomeCell")
        
        expenseCollectionView.register(nib, forCellWithReuseIdentifier: "expenceViewcell")
        
        self.hideKeyboardWhenTappedAround() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("category view will appear")
        self.navigationController?.navigationBar.topItem?.title = "Categories"
        
        if Language.currentLanguage() == "en" {
            self.navigationController?.navigationBar.topItem?.title = "Categories"
        }else{
            self.navigationController?.navigationBar.topItem?.title = "الفئه"
        }
        
        AllRequset().CategoriesOutCome(accesToken: HandleToken.token) { (result) in
            self.outCats = result.data
            self.expenseCollectionView.delegate = self
            self.expenseCollectionView.dataSource = self
            self.expenseCollectionView.reloadData()
            self.incomeCollectionView.reloadData()
        }
        

        AllRequset().CategoriesInCome(accesToken: HandleToken.token) { (result) in
            self.incomeCats = result.data
            self.incomeCollectionView.delegate = self
            self.incomeCollectionView.dataSource = self
            self.expenseCollectionView.reloadData()
            self.incomeCollectionView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "catIncomeAdded"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "catExpenceAdded"), object: nil)
    }
    
    
    @objc func notificationRecevied(notification: Notification) {
        print("Income Addeded")
        //self.alert(message: "Save Changes is Success", title: "Success")
        viewWillAppear(true)
    }
    
    @objc func notificationExpenceRecevied(notification: Notification) {
        print("Expence Addeded")
        //self.alert(message: "Save Changes is Success", title: "Success")
        viewWillAppear(true)
    }
    
    
    @IBAction func addExpenseActionButton(_ sender: UIButton) {
//        let popupAdditemVC  = addItemPopVC(nibName: "AddCategoryIncome", bundle: nil)
        let popAddExpenceAction = AddCategoryExpence(nibName: "AddCategoryExpence", bundle: nil)
        
        let popup = PopupDialog(viewController: popAddExpenceAction, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    @IBAction func addIncomeActionButton(_ sender: UIButton) {
        let popAddExpenceAction = AddCategoryIncome(nibName: "AddCategoryIncome", bundle: nil)
        
        let popup = PopupDialog(viewController: popAddExpenceAction, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        self.present(popup, animated: true, completion: nil)
    }
    
}

extension CategoryViewController :UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == expenseCollectionView {
            return outCats?.count ?? 0
        }
        return incomeCats?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == expenseCollectionView {
            self.categoryId = outCats![indexPath.row].id
            self.categoryType = 0
            performSegue(withIdentifier: "categoryItemSegue", sender: self)
        }else{
            self.categoryId = incomeCats![indexPath.row].id
            self.categoryType = 1
            performSegue(withIdentifier: "categoryItemSegue", sender: self)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryItemSegue" {
            let itemDetailsView = segue.destination as? ItemByCategoryViewController
            itemDetailsView?.catId = self.categoryId
            itemDetailsView?.type = self.categoryType
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == expenseCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "expenceViewcell", for: indexPath) as? ExpenceViewCell
            
            cell?.valueLabel.text = "\(outCats![indexPath.row].budget!)"
            cell?.imageView.image = UIImage(named: outCats![indexPath.row].icon!)
            
            cell?.typeLabel.text = outCats![indexPath.row].name
            
            return cell!
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "incomeCell", for: indexPath) as? IncomeCollectionViewCell
            cell?.incomeTypeLabel.text = incomeCats![indexPath.row].name
            cell?.incomeImageView.image = UIImage(named: incomeCats![indexPath.row].icon!)
            cell?.incomeValueLabel.text = "\(incomeCats![indexPath.row].money!)"
            
            return cell!
        }
    }
    
}

extension CategoryViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
