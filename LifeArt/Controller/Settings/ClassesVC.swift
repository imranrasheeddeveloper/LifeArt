

import UIKit



class ClassesVC: UIViewController {
    
    //MARK:-Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView : UIView!
    //MARK:-Variables
    var classesData = [Classess]()

    
    //MARK:-LifeCycles
    override func viewDidLoad() {
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
    
    
}
extension ClassesVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassesCell", for: indexPath) as! ClassesCell
        cell.nameOfInstitueLbl.text = classesData[indexPath.row].name
        cell.addressOfInstituteLbl.text = classesData[indexPath.row].address
        cell.nameOfDirectorLbl.text = classesData[indexPath.row].owner
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}





