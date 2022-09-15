//
//  DetailViewController.swift
//  BasicLayoutApp
//
//  Created by Denisse Verdiales on 07/07/22.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var imgAnimal: UIImageView!
        
    @IBOutlet weak var txtInfo: UILabel!
    
    
    var img: String = "", info: String = "", name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = self.name
        lblName.textColor = UIColor.purple
        imgAnimal.image = UIImage(named: self.img)
        txtInfo.text = self.info
    }
    
    func configureDetail(imgStr: String, name: String, info: String){
        self.img = imgStr
        self.info = info
        self.name = name
 
        
    }
    
    

}

