//
//  NetViewController.swift
//  IntroToNetworkingAssignment
//
//  Created by Denisse Verdiales on 11/07/22.
//

import UIKit

class NetViewController: UIViewController {

    lazy var table: UITableView = {
        
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
       // table.delegate = self
        table.register(NetTableViewCell.self, forCellReuseIdentifier: NetTableViewCell.reuseID)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
    }
    
    private func setUpUI(){
        self.view.backgroundColor = .white
        self.title = ""
        self.view.addSubview(self.table)
        self.table.bindToSuperview()
    }
}

extension NetViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NetTableViewCell.reuseID, for: indexPath) as? NetTableViewCell else{
            return UITableViewCell()
        }
    
        
        return cell
    }
    

}
