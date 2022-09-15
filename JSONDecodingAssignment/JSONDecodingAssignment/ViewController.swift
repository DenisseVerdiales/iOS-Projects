//
//  ViewController.swift
//  JSONDecodingAssignment
//
//  Created by Denisse Verdiales on 12/07/22.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var decodeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Manually Decode Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(self.manualDecodeButtonPressed), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
          self.view.addSubview(self.decodeButton)
          
          self.decodeButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
          self.decodeButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
          self.decodeButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
          self.decodeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
    
    @objc
    func manualDecodeButtonPressed() {
        
        let dragon = self.network.getDragonManually()
        self.presentDragonAlert(dragon: dragon)
    }
   
   func presentDragonAlert(dragon: Dragon?) {
       
       guard let dragon = dragon else { return }
          
    let generation = dragon.pokemon.compactMap{$0.pokemon.name}.reduce(""){partialResult, pokemon in
           return partialResult + pokemon + "\n"
       }

    let alert = UIAlertController(title: dragon.name, message: generation, preferredStyle: .alert)
       let action = UIAlertAction(title: "Pokemon Name ...", style: .default, handler: nil)
       alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
       }
          
   }

}

