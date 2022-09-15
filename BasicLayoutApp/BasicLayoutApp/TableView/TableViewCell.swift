//
//  TableViewCell.swift
//  BasicLayoutApp
//
//  Created by Denisse Verdiales on 07/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var animalImagenView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var chkEnable: UISwitch!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(imageStr: String, item: String){
        self.animalImagenView.image = UIImage(named: imageStr)
        self.lblName.text = "Animal - \(item)"
    }
    
    
}
