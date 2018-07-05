//
//  Home.swift
//  ManageMoney
//
//  Created by admin101 on 4/3/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import DTZFloatingActionButton
import PopupDialog
import SideMenu

class Home: UITabBarController{
    
    
    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLayoutSubviews() {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
                tabbar.frame = CGRect(x: 0, y:  tabbar.frame.size.height + 10, width: tabbar.frame.size.width, height: tabbar.frame.size.height + 4)
            default:
                print("unknown")
            }
        }
        
        tabbar.frame = CGRect(x: 0, y:  tabbar.frame.size.height, width: tabbar.frame.size.width, height: tabbar.frame.size.height + 4)

        super.viewDidLayoutSubviews()

    }
    override func viewWillDisappear(_ animated: Bool) {
        DTZFABManager.shared.hide()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DTZFABManager.shared.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        print(HandleToken.token)
        // Show StatusBar in MenuView
        
        SideMenuManager.default.menuFadeStatusBar = false
        
        // floatingButton declaration
        
        DTZFABManager.shared.button().handler = {
            button in
            let popupAdditemVC  = addItemPopVC(nibName: "addItemPopVC", bundle: nil)
            let popup = PopupDialog(viewController: popupAdditemVC, buttonAlignment: .horizontal, transitionStyle: .fadeIn, gestureDismissal: true)
            self.present(popup, animated: true, completion: nil)
        }
        
        tabbar.tintColor = UIColor.black
    }
    
    @IBAction func menuBtb(_ sender: UIBarButtonItem) {
        let vc = MainMenuViewController() as UIViewController
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: vc)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
    }
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: 0,y :size.height - lineWidth), size: CGSize(width: size.width, height: lineWidth)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
