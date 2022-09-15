//
//  clCollectionViewCell.swift
//  BasicLayoutApp
//
//  Created by Denisse Verdiales on 08/07/22.
//

import UIKit

class clCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgAnimal: UIImageView!
    
    
    @IBOutlet weak var lblNameAnimal: UILabel!
    
    
    @IBOutlet weak var lblTypeAnimal: UILabel!
    
    @IBOutlet weak var iconAnimal: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
    }
    
    func configure(imageStr: String, item: String){
        self.imgAnimal.image = UIImage(named: imageStr)
        self.lblNameAnimal.text = "Animal - \(item)"
        self.iconAnimal.image = UIImage(named: "fb")
    }

}
