//
//  DetailViewController.swift
//  iTunes
//
//  Created by Consultant on 7/23/22.
//

import UIKit

class DetailViewController: UIViewController {
    static let reusedId = "\(DetailViewController.self)"
    
    let albumDetail: AlbumViewModelType
    var indexDetail: Int = 0
    
    lazy var AlbumDetailTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.dataSource = self
        table.backgroundColor = .systemGray
        //  table.delegate = self
        table.register(AlbumDetailTableViewCell.self, forCellReuseIdentifier: AlbumDetailTableViewCell.reuseId)
        return table
           
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.view.backgroundColor = .systemGray
    }

    init(vm: AlbumViewModelType, index: Int) {
        self.albumDetail = vm
        self.indexDetail = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTableView(){
      
        self.view.addSubview(self.AlbumDetailTable)
        self.AlbumDetailTable.bindToSuperView()
     
   }
    
}
extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumDetailTableViewCell.reuseId, for: indexPath) as? AlbumDetailTableViewCell else {return UITableViewCell()}
        
        cell.configure(album: self.albumDetail, index: self.indexDetail)
        cell.backgroundColor = .systemGray
        return cell
    }
    
    
}
