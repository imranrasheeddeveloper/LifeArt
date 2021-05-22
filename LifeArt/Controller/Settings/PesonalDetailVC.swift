


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
        ApiCalling()
        hideKeyboard()
        navigationView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
    }
    

    //MARK:-Helper Functions
    func registerNib(){
        tableView.register(UINib(nibName: "PersonalDetailCell", bundle: nil), forCellReuseIdentifier: "PersonalDetailCell")
        
    }
    
    func ApiCalling() {
        UserService.shared.checkArtistExist(uid: GlobaluserID) { (result) in
            if result{
                UserService.shared.fetchArtistUser(uid: GlobaluserID) { [self] (user) in
                   
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Full Name", detailAnswerLbl: "\(user.firstname) \(user.lastname)", iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Email", detailAnswerLbl: user.email, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Country", detailAnswerLbl: user.country, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Bio", detailAnswerLbl: user.bio, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Website", detailAnswerLbl: user.website, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Phone", detailAnswerLbl: user.phone, iconImg: ""))
                    tableView.reloadData()
                    

                }
            }
            else{
                UserService.shared.fetchModelsUser(uid: GlobaluserID) { [self] (user) in
                 
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Full Name", detailAnswerLbl: "\(user.firstname) \(user.lastname)", iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Email", detailAnswerLbl: user.email, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Country", detailAnswerLbl: user.country, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Bio", detailAnswerLbl: user.bio, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Website", detailAnswerLbl: user.website, iconImg: ""))
                    personalDetailData.append(PersonalDetailModel(detailLbl: "Phone", detailAnswerLbl: user.phone, iconImg: ""))
                    tableView.reloadData()
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
