//
//  MovesTableViewCell.swift
//  Pokemon
//
//  Created by Consultant on 7/19/22.
//

import UIKit

class MovesTableViewCell: UITableViewCell {

    static let reusedId = "\(MovesTableViewCell.self)"
    
    lazy var pokemonMovesImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
      //  imageView.backgroundColor = .white
        imageView.image = UIImage(named: "pok")
        imageView.layer.cornerRadius = 50
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.0
        return imageView
    }()
    
    lazy var movesTitleName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "Moves: "
        label.layer.borderColor = UIColor.systemGray5.cgColor
        label.layer.borderWidth = 1.0
        //label.textColor = .white
        
        return label
    }()
    
    lazy var movesName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "Moves Name"
        //label.textColor = .white
        
        return label
    }()
    
    var pokemons: [PokemonDetail]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUpUI()

    }
    
    private func setUpUI(){
        self.addSubview(self.movesName)
        self.movesName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.movesName.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.movesName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        self.movesName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        
 
    }
    


}
