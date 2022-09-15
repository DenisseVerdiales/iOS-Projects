//
//  FavoriteViewController.swift
//  iTunes
//
//  Created by Consultant on 7/22/22.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    static let reusedId = "\(FavoriteViewController.self)"

    private var color: [selectColorFav] = []
    
    lazy var favoriteTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.dataSource = self
        table.delegate = self
        //table.prefetchDataSource = self
        table.register(favoriteDetailTableViewCell.self, forCellReuseIdentifier: favoriteDetailTableViewCell.reuseId)
        return table
            
    }()
    
    var albumFavVM: AlbumViewModel?
   
    let albumVMT: AlbumViewModelType
   
    init(vm: AlbumViewModelType) {
        self.albumVMT = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        self.title = "Favorite"
        
        self.setTableView()
        for i in 0 ..< 100 {
            color.append(selectColorFav.disLiked)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.favoriteTable.reloadData()
        }
    }
    
    func setTableView(){
          self.view.addSubview(self.favoriteTable)
          self.favoriteTable.bindToSuperView()
      }

}
extension FavoriteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumVMT.getFavAlbum().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteDetailTableViewCell.reuseId, for: indexPath) as? favoriteDetailTableViewCell else{
            return UITableViewCell()
        }
        cell.backgroundColor = .systemGray3
        cell.configure(album: self.albumVMT.getFavAlbum(), index: indexPath.row)
       // let model = color[indexPath.row]
       // cell.updateColor(with: model)
       // cell.delegateFav = self
        return cell
    }
    
}

extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let albumDetailVC = DetailViewController(vm: self.albumVMT, index: indexPath.row)
        self.navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}

extension FavoriteViewController: CellFavDelegate {
    func onCellModelChange(cell: favoriteDetailTableViewCell, model: selectColorFav) {
        guard let indexPath = favoriteTable.indexPath(for: cell) else {
            return
        }
        
        color[indexPath.row] = model
      //  cell.updateColor(with: model)
    
    }
}
