
import UIKit

class MonthTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var items:[ItemData]?
    var destinationData:ItemData?

    
    @IBOutlet weak var monthTableView: UITableView!
    
    let date = Date()
    
    let calender = NSCalendar.current

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let date = Date()
        let calendar = NSCalendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let week = calendar.component(.weekOfMonth, from: date)
        print("day : \(day)")
        print("month : \(month)")
        print("Week : \(week)")
        
        let table = UITableView(frame: CGRect(x: 0, y: (tabBarController?.tabBar.frame.size.height)! * 2, width: (tabBarController?.tabBar.frame.size.width)!, height: view.frame.size.height))
        view.addSubview(table)
        self.monthTableView = table
        
        self.monthTableView.register(UINib.init(nibName: "ItemManageViewCell" ,bundle : nil) , forCellReuseIdentifier: "itemManageViewCell")
        
    }
    
    @objc func notificationRecevied(notification: Notification) {
        print("Addeded")
        self.alert(message: "Save Changes is Success", title: "Success")
        viewWillAppear(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Language.currentLanguage()  == "en"{
            self.navigationController?.navigationBar.topItem?.title = "MONTHLY"
            self.showHud("Loading...")

        }else{
            self.navigationController?.navigationBar.topItem?.title = "شهريا"
            self.showHud("جار التحميل...")
        }
        
        AllRequset().getItems(accessToken: HandleToken.token) { (result) in
            
            print("print end loading ")
            self.items = result
            self.monthTableView.delegate = self
            self.monthTableView.dataSource = self
            self.monthTableView.reloadData()
            self.hideHUD()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "itemAdded"), object: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.monthTableView.dequeueReusableCell(withIdentifier: "itemManageViewCell", for: indexPath) as! ItemManageViewCell
        
        cell.itemNameLabel.text = self.items![indexPath.row].name
        cell.priceLabel.text = "\( String(describing: self.items![indexPath.row].price!))"
        
        cell.categoryLabel.text = self.items![indexPath.row].incomeCategoryName
        cell.notesLabel.text = self.items![indexPath.row].notes
        
        //delegate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.destinationData = items?[indexPath.row]
        performSegue(withIdentifier: "ItemSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemSegue" {
            let itemDetailsView = segue.destination as? ItemDetailsViewController
            itemDetailsView?.itemDetails = self.destinationData
        }
    }
    
}
