
import UIKit
import DropDown
class AddCategoryExpence: UIViewController {
  
    @IBOutlet weak var expenseLabel: UITextField!
    
    @IBOutlet weak var expenseBtn: UIButton!
    @IBOutlet weak var expenseValue: UITextField!
    
    let dropDownOutCome  = DropDown()
    
    var outComeArray: [String] = []
    
    var badgetValue = 0
    
    var expenceDropArray = ["Food" , "Home" , "Personal" , "Salary" , "Saving" , "Shopping" , "Child" , "Car" , "Kast" , "Credit"]
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround() 
        FillOutComeArray()
    }

    @IBAction func ExpenseBTn(_ sender: UIButton) {
        dropBadgetMenu()
        dropDownOutCome.show()
    }
    
    @IBAction func AddBtn(_ sender: UIButton) {
        if (expenseLabel.text?.isEmpty)! || (expenseValue.text?.isEmpty)! {
            self.alert(message: "All fileds are required , please try again", title: "Error!")
        }else{
            AllRequset().insertCategoryOutCome(id: 0, price: Double(expenseValue.text!)!, name: expenseLabel.text!, icon: expenceDropArray[badgetValue], accessToken: HandleToken.token, completion: { (statusCode) in
                if statusCode == 200{
                    self.dismiss(animated: true, completion: nil)
                    //catExpenceAdded
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "catExpenceAdded"), object:"added")
                }else{
                    //self.dismiss(animated: true, completion: nil)
                    if Language.currentLanguage() == "en" {
                        self.alert(message: "Error to inserting a new category , please try again!", title: "Error!")
                    }else{
                        self.alert(message: "حدث خطأ في إدراج فئة جديدة ، يرجى المحاولة مرة أخرى!", title: "خطأ!")
                    }
                    
                }
            })
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func FillOutComeArray(){
    AllRequset().CategoriesOutCome(accesToken: HandleToken.token) { (category) in
            
            for item in category.data!
            {
                self.outComeArray.append(item.name!)
                
            }
            
        }
    }
    
    func  dropBadgetMenu() {
        dropDownOutCome.anchorView = expenseBtn
        dropDownOutCome.bottomOffset = CGPoint(x: 0, y: expenseBtn.bounds.height)
        dropDownOutCome.dataSource = self.expenceDropArray
        dropDownOutCome.selectionAction = { [weak self] (index, item) in
            self?.expenseBtn.setTitle(item, for: .normal)
            self?.badgetValue = index
        }
    }
    
}
