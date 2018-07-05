//
//  Calendar.swift
//  ManageMoney
//
//  Created by admin101 on 4/3/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import FSCalendar

class Calendar: UIViewController ,FSCalendarDelegate ,FSCalendarDataSource{
    
    fileprivate weak var calendar: FSCalendar!
    
    override func viewWillAppear(_ animated: Bool) {
        if Language.currentLanguage() == "en" {
            self.navigationController?.navigationBar.topItem?.title = "Calendar"
        }else{
            self.navigationController?.navigationBar.topItem?.title = "الاجندة"
            self.hideKeyboardWhenTappedAround()
            
        }
    }

  

    override func viewDidLoad() {
        super.viewDidLoad()
        


        let calendar = FSCalendar(frame: CGRect(x: 0, y: (tabBarController?.tabBar.frame.size.height)! * 2, width: (tabBarController?.tabBar.frame.size.width)!, height: 350))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
