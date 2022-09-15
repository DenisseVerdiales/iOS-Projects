//
//  CollectionViewController.swift
//  BasicLayoutApp
//
//  Created by Denisse Verdiales on 08/07/22.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var AnimalCollectionView: UICollectionView!
    
    let animals = itemAnimals().animal()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.AnimalCollectionView.dataSource = self
        self.AnimalCollectionView.delegate = self
        self.AnimalCollectionView.register(UINib(nibName: "clCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "clCollectionViewCell")
    }
    
}

extension CollectionViewController: UICollectionViewDataSource{
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clCollectionViewCell", for: indexPath) as? clCollectionViewCell else{
            return UICollectionViewCell()
        }
    
        let animal = animals[indexPath.row]
        
        cell.imgAnimal.image = UIImage(named: animal.image)
        cell.lblNameAnimal.text = "Name:" + animal.name
        cell.lblTypeAnimal.text = "Type: " + animal.type
        cell.iconAnimal.image = UIImage(named: "fb")
        
        return cell
        
        
    }
    
    
}
