//
//  AlbumViewController.swift
//  iTunes
//
//  Created by Consultant on 7/22/22.
//

import UIKit

class AlbumViewController: UIViewController {
    static let reusedId = "\(AlbumViewController.self)"

    private var color: [selectColorFav] = []
    
    lazy var albumTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.dataSource = self
        table.delegate = self
        //table.prefetchDataSource = self
        table.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.reuseId)
        return table
            
    }()
    
    let albumVM: AlbumViewModelType

    init(vm: AlbumViewModelType) {
        self.albumVM = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.view.backgroundColor = .systemGray3
        self.title = "Top 100"
        
        self.albumVM.bind {
            DispatchQueue.main.async {
                self.albumTable.reloadData()
            }
        }
        self.albumVM.getAlbums()
        
        for _ in 0 ..< 100 {
            color.append(selectColorFav.disLiked)
        }
    }
    
    func setTableView(){
          self.view.addSubview(self.albumTable)
          self.albumTable.bindToSuperView()
      }

}

extension AlbumViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorColor = .systemYellow
        return self.albumVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseId, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .systemGray3
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemTeal
        cell.selectedBackgroundView = backgroundView
        
        let model = color[indexPath.row]
        cell.updateColor(with: model)
        cell.delegate = self
        cell.configure(album: self.albumVM, index: indexPath.row)
        
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let albumDetailVC = DetailViewController(vm: self.albumVM, index: indexPath.row)
        
        self.navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}

extension AlbumViewController: CellDelegate {
    func onCellModelChange(cell: AlbumTableViewCell, model: selectColorFav) {
        guard let indexPath = albumTable.indexPath(for: cell) else {
            return
        }
        
        color[indexPath.row] = model
        cell.updateColor(with: model)
    
    }
}
