//
//  MenuChooseDate.swift
//  ManageMoney
//
//  Created by admin101 on 4/7/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import FSCalendar

class MenuChooseDate : UIViewController ,FSCalendarDelegate ,FSCalendarDataSource{
    
    fileprivate weak var calendar: FSCalendar!
    
    var selectedDate : String?
   
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Language.currentLanguage() == "en" {
            self.navigationController?.navigationBar.topItem?.title = "Choose Date"
        }else{
            self.navigationController?.navigationBar.topItem?.title = "أختار تاريخ"
            //self.navigationItem.backBarButtonItem?.title = ""
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        self.selectedDate = dateFormatter.string(from: date)
        
        // Calendar
        let calendar = FSCalendar(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.size.height)! * 2, width: (navigationController?.navigationBar.frame.size.width)!, height: 350))
        

        
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
        
        // Button
        let button = UIButton(frame: CGRect(x: view.frame.size.width / 2.5, y:  calendar.frame.size.height + (navigationController?.navigationBar.frame.size.height)! * 3, width: 100, height: 50))
       // self.makeRadiosView(view: button, radios: 1)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.05882352941, green: 0.368627451, blue: 0.4705882353, alpha: 1)
        if Language.currentLanguage() == "en" {
            button.setTitle("Done", for: .normal)

        }else{
            button.setTitle("تم", for: .normal)
        }
        
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(button)
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        self.selectedDate = dateFormatter.string(from: date)
    }
    
    @objc func buttonAction(){
        let storyboard = UIStoryboard(name: "ChooseDateItems", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "chooseDay") as! DayItemsViewController
        
        vc.selectedDay = Int(self.selectedDate!)
        
        navigationController?.pushViewController(vc,animated: true)
    }
    
}

