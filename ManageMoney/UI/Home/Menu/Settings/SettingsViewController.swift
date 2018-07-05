//
//  SettingsViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/6/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import PopupDialog
import DropDown

class SettingsViewController: UIViewController {
    @IBOutlet weak var changePAsswordButton: UIButton!
    
    @IBOutlet weak var dailyAlertButton: UIButton!
    @IBOutlet weak var deleteDatabaseButton: UIButton!
    @IBOutlet weak var creteBackupButton: UIButton!
    
    @IBOutlet weak var exportFileButton: UIButton!
    @IBOutlet weak var budgetValueUIView: UIView!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var budgetValueLabel: UILabel!
    
    @IBOutlet weak var budgetImage: UIImageView!
    
    @IBOutlet weak var dayButton: UIButton!
    
    @IBOutlet weak var alertImage: UIImageView!
    
    @IBOutlet weak var changeLanButton: UIButton!
    
    @IBOutlet weak var dayView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    var alertFlag = false
    
    var weakDays = ["Sunday","Monday","Tuesday","Wensday","Thursday","Friday","Saturday"]
    
    var arabicWeakDays = ["الأحد","الأثنين","الثلاثاء","الأربعاء","الخميس","الجمعه","السبت"]
    let dropDownWeak  = DropDown()
    var beginDayWeak :Int = 3 // From my Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        alertImage.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        
        budgetValueLabel.isUserInteractionEnabled = true
        budgetValueLabel.addGestureRecognizer(tap)
        
        budgetLabel.isUserInteractionEnabled = true
        budgetLabel.addGestureRecognizer(tap)
        
        budgetValueUIView.isUserInteractionEnabled = true
        budgetValueUIView.addGestureRecognizer(tap)
        AllRequset().getUserInfo(accessToken: HandleToken.token) { (result) in
            self.budgetValueLabel.text = "\(result.BadgetValue!)"
            if result.BegainDay! > 6 {
                self.dayButton.setTitle(self.weakDays[0], for: .normal)
            }else{
                self.dayButton.setTitle(self.weakDays[result.BegainDay ?? 0], for: .normal)
            }
            if result.DailyAlert! == true {
                self.alertFlag = true
                self.alertImage.isHidden = false
            }else{
                self.alertFlag = false
            }
        }
        
        setAnimationForAllView()
    }
    
    func setAnimationForAllView() {
        
        self.makeShadowForView(view: budgetValueUIView)
        self.makeShadowForView(view: dayView)
        self.makeShadowForView(view: changePAsswordButton)
        self.makeShadowForView(view: alertView)
        self.makeShadowForView(view: exportFileButton)
        //self.makeShadowForView(view: creteBackupButton)
        self.makeShadowForView(view: deleteDatabaseButton)
        self.makeShadowForView(view: changeLanButton)
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let popupAdditemVC  = BudgetVc(nibName: "BudgetVc", bundle: nil)
        let popup = PopupDialog(viewController: popupAdditemVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        self.present(popup, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Language.currentLanguage() == "en" {

            self.navigationController?.navigationBar.topItem?.title = "Settings"
        }else{
            dayButton.contentHorizontalAlignment = .right
            exportFileButton.contentHorizontalAlignment = .right
            dailyAlertButton.contentHorizontalAlignment = .right
           // creteBackupButton.contentHorizontalAlignment = .right
            changePAsswordButton.contentHorizontalAlignment = .right
            deleteDatabaseButton.contentHorizontalAlignment = .right
            changeLanButton.contentHorizontalAlignment = .right
            //budgetLabel.content
            exportFileButton.setTitle("ملف التصدير", for: UIControlState.normal)
           
           deleteDatabaseButton.setTitle("مسح جميع الداتا ", for: UIControlState.normal)
            
           changeLanButton.setTitle("تغير اللغه الي الانجليزيه", for:UIControlState.normal)
           
           
//            creteBackupButton.setTitle("إنشاء نسخة احتياطية للبيانات", for: UIControlState.normal)
            self.navigationController?.navigationBar.topItem?.title = "الأعدادات"
            //self.navigationItem.backBarButtonItem?.title = ""
            self.weakDays = arabicWeakDays
        }
        
        
        //budgetVc?.changingBadget = self
        showHud("loading...")
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "newDataToLoad"), object: nil)
        self.budgetImage.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(passwordNotifiRecevied(notification:)), name: NSNotification.Name(rawValue: "passwordReset"), object: nil)
        self.budgetImage.isHidden = true
        
        AllRequset().getUserInfo(accessToken: HandleToken.token) { (result) in
            self.budgetValueLabel.text = "\(result.BadgetValue!)"
            if result.BegainDay! > 6 {
                self.dayButton.setTitle(self.weakDays[6], for: .normal)
            }else {
                self.dayButton.setTitle(self.weakDays[result.BegainDay ?? 0], for: .normal)
            }
            if result.DailyAlert! == true {
                self.alertFlag = true
                self.alertImage.isHidden = false
            }else{
                self.alertFlag = false
            }
            
            self.hideHUD()
        }
    
    }
    
    @objc func notificationRecevied(notification: Notification) {
        let data = notification.object
        if Language.currentLanguage() == "en" {
            self.alert(message: "Infromation Changed Successfuly", title: "Success!")
        }else {
            self.alert(message: "تم تغيير المعلومات بنجاح!", title: "نجاح!")
        }
        self.budgetValueLabel.text = "\(data!)"
        self.budgetImage.isHidden = false
    }
    
    @objc func passwordNotifiRecevied(notification: Notification) {
        print("pass rec")
        if Language.currentLanguage() == "en" {
            self.alert(message: "Password Changed Successfully", title: "Success!")
        }else{
            self.alert(message: "تم تغيير الرقم السري بنجاح", title: "نجاح!")
        }
    }

    @IBAction func changeLanguageBtn(_ sender: UIButton) {
        if Language.currentLanguage() == "ar-EG" {
            Language.setAppLanguage(lang: "en")
        }else {
            Language.setAppLanguage(lang: "ar-EG")
        }
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        let sb = UIStoryboard(name: "Login", bundle: nil)
        window?.rootViewController = sb.instantiateViewController(withIdentifier: "Login")
        
        UIView.transition(with: window!, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
        let popupAdditemVC  = PasswordVC(nibName: "PasswordVC", bundle: nil)
        let popup = PopupDialog(viewController: popupAdditemVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        self.present(popup, animated: true, completion: nil)
    }
    
    @IBAction func dayButtonAction(_ sender: UIButton) {
        drop()
        dropDownWeak.show()
    }
    
    func  drop() {
        self.dropDownWeak.anchorView = dayButton
        dropDownWeak.bottomOffset = CGPoint(x: 0, y: dayButton.bounds.height)
        dropDownWeak.dataSource = weakDays
        dropDownWeak.selectionAction = { [weak self] (index, item) in
            print("\(index)")
            self?.updateBeginningDay(day: index)
            self?.dayButton.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func DailyAlert(_ sender: UIButton) {
        if alertFlag == true{
            self.alertImage.isHidden = true
            alertFlag = false
           // AllRequset().upda
            updateDailyAlert(alertFlag: alertFlag)
        }else{
            alertFlag = true
            self.alertImage.isHidden = false
            updateDailyAlert(alertFlag: alertFlag)
        }
    }
    
    func updateBeginningDay(day:Int){
        AllRequset().getUserInfo(accessToken: HandleToken.token) { (result) in
            
            AllRequset().updateUserInfo(Email: result.Email!, FullName: result.FullName!, ConcuranceyId: result.ConcuranceyId!, BadgetSelected: result.BadgetSelected!, BadgetValue: result.BadgetValue!, DailyAlert: result.DailyAlert!, BegainDay: day, accessToken: HandleToken.token,success: { (success) in
                
                self.hideHUD()
            }, error: { (error) in
                
            })
            
        }
        
    }
    
    func updateDailyAlert(alertFlag:Bool){
        AllRequset().getUserInfo(accessToken: HandleToken.token) { (result) in
            AllRequset().updateUserInfo(Email: result.Email!, FullName: result.FullName!, ConcuranceyId: result.ConcuranceyId!, BadgetSelected: result.BadgetSelected!, BadgetValue: result.BadgetValue!, DailyAlert: alertFlag, BegainDay: 8, accessToken: HandleToken.token, success: { (success) in
                if success.code == 0{
                    print("code 0")
                    self.alert(message: success.message, title: "Error!")
                }else{
                    print("else code 0")
                    self.alert(message: success.message, title: "Success!")
                }
            }, error: { (error) in
                print("error alert code 0")
               self.alert(message: "Error To update your information", title: "Error!")
            })
        }
    }
    
    @IBAction func deleteDatabaseAction(_ sender: UIButton) {
        
        var uiOkAlertActionTitle = "Ok"
        var uiCancelAlertActionTitle = "Cancel"
        
        var alertController = UIAlertController(title: "Warning!", message: "Are you sure want to delete this item ?", preferredStyle: .alert)
        
        if Language.currentLanguage() != "en" {
            alertController = UIAlertController(title: "تحذير!", message: "هل أنت متأكد من حذف قاعدة البيانات الخاصة بك؟", preferredStyle: .alert)
            uiOkAlertActionTitle = "نعم"
            uiCancelAlertActionTitle = "إلغاء"
        }
        
        // Create the actions
        let okAction = UIAlertAction(title: uiOkAlertActionTitle, style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            AllRequset().deleteAllData(completion: { (code) in
                print(code)
                if code != 200 {
                    if Language.currentLanguage() == "en" {
                        self.alert(message: "Something wrong happened when deleting your database ,Please try again!", title: "Error!")
                    }else{
                        self.alert(message: "حدث خطأ ما عند حذف قاعدة البيانات الخاصة بك ، يرجى المحاولة مرة أخرى!", title: "خطأ")
                    }
                }else{
                    if Language.currentLanguage() == "en" {
                        self.alert(message: "Your database was deleted succssfully!", title: "Success!")
                    }else{
                        self.alert(message: "تم حذف قاعدة البيانات الخاصة بك بنجاح!", title: "تم!")
                    }
                }
            })
            
            NSLog("OK Pressed")
        }
        let cancelAction = UIAlertAction(title: uiCancelAlertActionTitle, style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func exportFileButton(_ sender: UIButton) {
        AllRequset().getAllData { (result) in
            if result.code != 0 {
                if !result.url.isEmpty  {
                    let firstActivityItem = "Text you want"
                    let secondActivityItem : NSURL = NSURL(string: result.url)!
                    // If you want to put an image
                    let image : UIImage = UIImage(named: "Food")!
                    
                    let activityViewController : UIActivityViewController = UIActivityViewController(
                        activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
                    
                    // This lines is for the popover you need to show in iPad
                    activityViewController.popoverPresentationController?.sourceView = (sender )
                    
                    // This line remove the arrow of the popover to show in iPad
                    
                    activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
                    
                    activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                    
                    // Anything you want to exclude
                    activityViewController.excludedActivityTypes = [
                        UIActivityType.postToWeibo,
                        UIActivityType.print,
                        UIActivityType.assignToContact,
                        UIActivityType.saveToCameraRoll,
                        UIActivityType.addToReadingList,
                        UIActivityType.postToFlickr,
                        UIActivityType.postToVimeo,
                        UIActivityType.postToTencentWeibo,
                        UIActivityType.mail,
                        UIActivityType.markupAsPDF,
                        UIActivityType.message,
                        UIActivityType.postToFacebook,
                        UIActivityType.postToTwitter,
                        UIActivityType.openInIBooks,
                        UIActivityType.airDrop,
                    ]
                    
                    self.present(activityViewController, animated: true, completion: nil)
                }
            }
            
            else{
                if Language.currentLanguage() == "en" {
                    self.alert(message: "You cann't export your file now , please try again later!", title: "Error!")
                }else{
                    self.alert(message:"لا يمكنك تصدير ملفك الآن ، يرجى المحاولة مرة أخرى في وقت لاحق!", title: "خطأ!")
                }
            }
            
        }
        
    }
    
    @IBAction func createDataBackupAction(_ sender: UIButton) {
        
    }
    
}
