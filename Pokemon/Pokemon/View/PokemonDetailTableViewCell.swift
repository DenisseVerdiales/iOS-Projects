//
//  PokemonDetailTableViewCell.swift
//  Pokemon
//
//  Created by Consultant on 7/16/22.
//

import UIKit

class PokemonDetailTableViewCell: UITableViewCell {

    static let reusedId = "\(PokemonDetailTableViewCell.self)"
    
    lazy var progImageView: UIImageView = {
         let imageView = UIImageView(frame: .zero)
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         //imageView.backgroundColor = .systemGray
         
         return imageView
     }()
     
     lazy var progTopLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         label.textAlignment = NSTextAlignment.center
         label.textColor = .systemPurple
         //label.backgroundColor = .systemOrange
         
         return label
     }()
     lazy var progBottomLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         label.textAlignment = NSTextAlignment.justified
         //label.backgroundColor = .systemOrange
         
         return label
     }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.setUpUI()
    }
    
    private func setUpUI(){

       let vStackView = UIStackView(frame: .zero)
       vStackView.translatesAutoresizingMaskIntoConstraints = false
       vStackView.spacing = 8
       vStackView.axis = .vertical
       vStackView.distribution = .equalSpacing
       
       
       vStackView.addArrangedSubview(self.progTopLabel)
       vStackView.addArrangedSubview(self.progImageView)
       vStackView.addArrangedSubview(self.progBottomLabel)
       
       self.progTopLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
       self.progTopLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
       
       self.progImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
       self.progImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
       
       self.progBottomLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
       self.progBottomLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
       
   
       self.view.addSubview(vStackView)
       vStackView.bindToSuperView()
   }

}
