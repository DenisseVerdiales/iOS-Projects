//
//  StartViewController.swift
//  Pokemon
//
//  Created by Consultant on 7/18/22.
//

import UIKit

class StartViewController: UIViewController {

    lazy var startImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.gifImageWithURL("https://c.tenor.com/T7TK5_jVeMoAAAAd/pokeball.gif")
        return imageView
    }()
    
    lazy var startButtonView: UIButton = {
        let btnStart = UIButton(frame: .zero)
        btnStart.translatesAutoresizingMaskIntoConstraints = false
        btnStart.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnStart.backgroundColor = .systemRed
        btnStart.setTitle("Start", for: .normal)
        btnStart.setTitleColor(.white, for: .normal)
        btnStart.layer.cornerRadius = 5
        btnStart.addTarget(self, action: #selector(ButtonPresented), for: .touchUpInside)
        
        return btnStart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.view.addSubview(self.startImageView)
        self.startImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.startImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.startImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.startImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        self.view.addSubview(self.startButtonView)
        self.startButtonView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.startButtonView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.startButtonView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.startButtonView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        self.startButtonView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -450).isActive = true
    }
    
    @objc
    func ButtonPresented(){
        let detailView = MainViewController()
        self.navigationController?.pushViewController(detailView, animated: true)
    }

}
