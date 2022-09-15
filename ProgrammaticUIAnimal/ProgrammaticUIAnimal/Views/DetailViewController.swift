//
//  DetailViewController.swift
//  ProgrammaticUIAnimal
//
//  Created by Denisse Verdiales on 09/07/22.
//

import UIKit

class DetailViewController: UIViewController {

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
    
    let titleName: String, text: String, img: String
    
    init(text: String, img: String, title: String){
        self.text = text
        self.img = img
        self.titleName = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6

        self.setUpUI()
        self.progTopLabel.text =  self.titleName
        self.progImageView.image = UIImage(named: self.img)
        self.progBottomLabel.text = self.text
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
        vStackView.bindToSuperview()
    }
    

}
