

import UIKit



struct ClassesModel {
    var nameOfInstitueLbl : String
    var addressOfInstituteLbl : String
    var nameOfDirectorLbl  : String
    var imgView : [UIImage]
}

class ClassesVC: UIViewController {
    
    //MARK:-Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView : UIView!
    //MARK:-Variables
    var classesData = [ClassesModel]()
    
    
    //MARK:-LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        loadData()
        setStatusBar()
        hideKeyboard()
        navigationView.dropShadow()
        navigationView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
    }
    
    //MARK:-Helper Functions
    func registerNib(){
        tableView.register(UINib(nibName: "ClassesCell", bundle: nil), forCellReuseIdentifier: "ClassesCell")
    }
    
    
    func loadData(){
        classesData.append(ClassesModel(nameOfInstitueLbl: "Institute Of Art $ Gallery", addressOfInstituteLbl: "Keas 69 str. 15624, Chalendri Athens,Greece", nameOfDirectorLbl: "Directed By:John William", imgView: []))
        
        classesData.append(ClassesModel(nameOfInstitueLbl: "Institute Of Art $ Gallery", addressOfInstituteLbl: "Keas 69 str. 15624, Chalendri Athens,Greece", nameOfDirectorLbl: "Directed By:John William", imgView: []))
    }
    
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
        cell.nameOfInstitueLbl.text = classesData[indexPath.row].nameOfInstitueLbl
        cell.addressOfInstituteLbl.text = classesData[indexPath.row].addressOfInstituteLbl
        cell.nameOfDirectorLbl.text = classesData[indexPath.row].nameOfDirectorLbl
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}





