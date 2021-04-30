

import UIKit

class PersonalDetailCell: UITableViewCell {

    //MARK:-Outlets
    
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var detailAnswerLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    
    //MARK:-Cell Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
