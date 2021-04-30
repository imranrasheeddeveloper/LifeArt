


import UIKit


struct PersonalDetailModel {
    var detailLbl : String
    var detailAnswerLbl : String
    var iconImg : String
}
class PesonalDetailVC: UIViewController {

    //MARK:-Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView : UIView!
    
    //MARK:-VAriables
    var personalDetailData = [PersonalDetailModel]()
    
    //MARK:-Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        registerNib()
        loadData()
        hideKeyboard()
        navigationView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
    }
    

    //MARK:-Helper Functions
    func registerNib(){
        tableView.register(UINib(nibName: "PersonalDetailCell", bundle: nil), forCellReuseIdentifier: "PersonalDetailCell")
        
    }
    func loadData(){
        personalDetailData.append(PersonalDetailModel(detailLbl: "Full Name", detailAnswerLbl: "John Duo", iconImg: ""))
        personalDetailData.append(PersonalDetailModel(detailLbl: "Email", detailAnswerLbl: "JohnDo@gmail.com", iconImg: ""))
        personalDetailData.append(PersonalDetailModel(detailLbl: "Country", detailAnswerLbl: "Pakistan", iconImg: ""))
        personalDetailData.append(PersonalDetailModel(detailLbl: "Gender", detailAnswerLbl: "Mail", iconImg: ""))
        personalDetailData.append(PersonalDetailModel(detailLbl: "Website", detailAnswerLbl: "www.bbc.com", iconImg: ""))
        personalDetailData.append(PersonalDetailModel(detailLbl: "Youtube", detailAnswerLbl: "Lorem Ibs", iconImg: ""))
    }

}
extension PesonalDetailVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalDetailData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalDetailCell", for: indexPath) as! PersonalDetailCell
        cell.detailLbl.text = personalDetailData[indexPath.row].detailLbl
        cell.detailAnswerLbl.text = personalDetailData[indexPath.row].detailAnswerLbl
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
