//
//  MainViewController.swift
//  ProgrammaticUIAnimal
//
//  Created by Denisse Verdiales on 09/07/22.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var table: UITableView = {
        
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(ProgTableViewCell.self, forCellReuseIdentifier: ProgTableViewCell.reuseID)
        
        return table
    }()
    let animal = itemsAnimal().animal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()

    }
    
    private func setUpUI(){
        self.view.backgroundColor = .white
        self.title = "Fantastic Beasts"
        self.view.addSubview(self.table)
        self.table.bindToSuperview()
    }

}
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgTableViewCell.reuseID, for: indexPath) as? ProgTableViewCell else{
            return UITableViewCell()
        }
        
        let valueAnimal = animal[indexPath.row]
        
        cell.progTopLabel.text = "No. " + String(indexPath.item)
        cell.progMidLabel.text = "Name: " + valueAnimal.name
        cell.progBottomLabel.text = "Type: " + valueAnimal.type
        
        cell.progImageView.image = UIImage(named: valueAnimal.image)

        return cell
    }
}

extension MainViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let infoDetail = animal[indexPath.row]
        let detailVC = DetailViewController(text: infoDetail.info, img:infoDetail.image, title: infoDetail.name)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
