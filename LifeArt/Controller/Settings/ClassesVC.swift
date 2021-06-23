

import UIKit



class ClassesVC: UIViewController, UITextFieldDelegate {
    
    //MARK:-Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView : UIView!
    
    @IBOutlet weak var searchBar: UITextField!
    
    //MARK:-Variables
    var classesData = [Classess]()
    var isSearch = false
    var fillterArray = [Classess]()
    //MARK:-LifeCycles
    override func viewDidLoad() {
        searchBar.delegate = self
        super.viewDidLoad()
        registerNib()
        setStatusBar()
        hideKeyboard()
        navigationView.dropShadow()
        navigationView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
    }
    override func viewWillAppear(_ animated: Bool) {
        apiCalling()
    }
    //MARK:-Helper Functions
    func registerNib(){
        tableView.register(UINib(nibName: "ClassesCell", bundle: nil), forCellReuseIdentifier: "ClassesCell")
    }
    
    //MARK:- Apis
    
    func apiCalling() {
        ClassesService.shared.fetchClassess { (clases) in
            self.classesData = clases
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    

    //MARK-: Actions
    @IBAction func addnewClass(sender : UIButton){
        self.pushToRoot(from: .Settings, identifier: .NewclassesVC)
    }
    
    @IBAction func backButton(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func searchBarAction(_ sender: UITextField) {
        
            isSearch = true
            fillterArray.removeAll()
            fillterArray = classesData.filter({
                if  $0.name.contains(sender.text!) {
                    self.tableView.reloadData()
                    return true
                }
                else{
                    self.tableView.reloadData()
                   return false
                }
            
            })
        if sender.text?.count == 0{
                isSearch = false
                self.tableView.reloadData()
            }
        self.tableView.reloadData()
        
    }
    
    
    
}
extension ClassesVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch == true {
            return fillterArray.count
        }
        else{
            return classesData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassesCell", for: indexPath) as! ClassesCell
        if isSearch == true {
            cell.nameOfInstitueLbl.text = fillterArray[indexPath.row].name
            cell.addressOfInstituteLbl.text = fillterArray[indexPath.row].address
            cell.nameOfDirectorLbl.text = fillterArray[indexPath.row].owner
            cell.imgView.sd_setImage(with:URL(string: fillterArray[indexPath.row].image),
                                    placeholderImage: UIImage(named: "placeholder.png"))
            cell.selectionStyle = .none
        }
        else{
            cell.nameOfInstitueLbl.text = classesData[indexPath.row].name
            cell.addressOfInstituteLbl.text = classesData[indexPath.row].address
            cell.nameOfDirectorLbl.text = classesData[indexPath.row].owner
            cell.imgView.sd_setImage(with:URL(string: classesData[indexPath.row].image),
                                    placeholderImage: UIImage(named: "placeholder.png"))
            cell.selectionStyle = .none
        }
       
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}



