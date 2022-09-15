//
//  TableViewAnimalViewController.swift
//  BasicLayoutApp
//
//  Created by Denisse Verdiales on 07/07/22.
//

import UIKit

class TableViewAnimalViewController: UIViewController {


    @IBOutlet weak var AnimalTableView: UITableView!
    
    let animals = itemAnimals().animal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AnimalTableView.dataSource = self
        self.AnimalTableView.delegate = self
        self.AnimalTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    
    
}

extension TableViewAnimalViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else{
            return UITableViewCell()
        }
        
        let animal = animals[indexPath.row]
        
        cell.animalImagenView.image = UIImage(named: animal.image)
        cell.lblName.text = "Name:" + animal.name
        cell.lblType.text = "Type: " + animal.type
        
        return cell
        
    }
}

extension TableViewAnimalViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoDetail = animals[indexPath.row]
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        vc.configureDetail(imgStr: infoDetail.image, name: infoDetail.name, info: infoDetail.info)
        self.navigationController?.pushViewController(vc, animated: true)
        
    
    }

}
