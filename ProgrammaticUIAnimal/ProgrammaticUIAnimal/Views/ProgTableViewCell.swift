//
//  ProgTableViewCell.swift
//  ProgrammaticUIAnimal
//
//  Created by Denisse Verdiales on 09/07/22.
//

import UIKit

class ProgTableViewCell: UITableViewCell {

    static let reuseID = "\(ProgTableViewCell.self)"
    
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
        //label.backgroundColor = .systemOrange
        
        return label
    }()
    
    lazy var progMidLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
       // label.backgroundColor = .systemFill
        
        return label
    }()
    
    lazy var progBottomLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        self.contentView.backgroundColor = .clear
        
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        
        vStackView.addArrangedSubview(self.progTopLabel)
        vStackView.addArrangedSubview(self.progMidLabel)
        vStackView.addArrangedSubview(self.progBottomLabel)
        
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.spacing = 8
        hStackView.axis = .horizontal
        
        hStackView.addArrangedSubview(self.progImageView)
        hStackView.addArrangedSubview(vStackView)
        
        self.progImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.progImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.contentView.addSubview(hStackView)
        hStackView.bindToSuperview()
        
    }
    
    
    
    
}
