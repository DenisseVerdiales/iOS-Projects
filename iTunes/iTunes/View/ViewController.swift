//
//  ViewController.swift
//  iTunes
//
//  Created by Consultant on 7/22/22.
//

import UIKit

class ViewController: UITabBarController {

    let albumVMT: AlbumViewModelType
    
    init(vm: AlbumViewModelType){
        self.albumVMT = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        
        let tabAlbum = UINavigationController(rootViewController: AlbumViewController(vm: AlbumViewModel(networkManager: NetworkManager())))
        let tabFavourite =  UINavigationController(rootViewController: FavoriteViewController(vm: AlbumViewModel(networkManager: NetworkManager())))
        
        self.setViewControllers([tabAlbum, tabFavourite], animated: true)
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .purple
        tabBar.tintColor = .systemTeal
        tabBar.barTintColor = .systemGray
        tabAlbum.title = "Top 100"
        tabFavourite.title = "Favorite"
        self.tabBar.items?[0].image = UIImage(systemName: "music.note.list")
        self.tabBar.items?[1].image = UIImage(systemName: "heart")
        
    }
    
  
    
}

