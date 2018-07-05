//
//  MenuCalendar.swift
//  ManageMoney
//
//  Created by admin101 on 4/5/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import FSCalendar

class MenuCalendar : UIViewController ,FSCalendarDelegate ,FSCalendarDataSource{
    
    fileprivate weak var calendar: FSCalendar!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Calendar"
        
        if Language.currentLanguage() == "en" {
            self.navigationController?.navigationBar.topItem?.title = "Calendar"
        }else{
            self.navigationController?.navigationBar.topItem?.title = "الاجندة"
            self.hideKeyboardWhenTappedAround()

            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let calendar = FSCalendar(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.size.height)! * 2, width: (navigationController?.navigationBar.frame.size.width)!, height: 350))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
    }
  
}

