//
//  ViewModel.swift
//  iTunes
//
//  Created by Consultant on 7/22/22.
//

import Foundation
import CoreData

protocol AlbumViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getAlbums()
    func getFavAlbum() ->[Albums]
    func makeFavorite(index: Int)
    func deleteFavorite()
}

protocol AlbumViewModelAttributes{
    var count: Int {get}
   // func id(for index: Int) -> Int?
    func albumName(for index: Int) -> String?
    func AlbumArtist(for index: Int) -> String?
    func releaseDate(for index: Int) -> String?
    func genres(for index: Int) -> String?
    func albumImage(for index: Int, completion: @escaping(Data?)->Void)
}

protocol AlbumViewModelAttributesFav{
    func id(for index: Int) -> Int?
    func favoriteA(for index: Int) -> Bool?
}

typealias AlbumViewModelType = AlbumViewModelCore & AlbumViewModelAttributes & AlbumViewModelAttributesFav

class AlbumViewModel{
    var manager: CoreDataManager
    
    var albums: [Results] = []{
        didSet{
            self.updateHandler?()
        }
    }
    
    var favoriteArray: [Albums]? = []{
        didSet{
            self.updateHandler?()
        }
    }
    
    var favorites: Albums? {
        didSet{
            self.updateHandler?()
        }
    }
    
    var selectFav: [Favorite] = []{
        didSet{
            self.updateHandler?()
        }
    }
    
    private var networkManager: NetworkService
    private var pageCount = 1
    
    private var updateHandler: (() -> Void)?
    
    init(networkManager: NetworkService, manager: CoreDataManager = CoreDataManager()) {
        self.networkManager = networkManager
        self.manager = manager
    }
    
    func bind(update: @escaping() -> Void){
        self.updateHandler = update
    }
        
}

extension AlbumViewModel: AlbumViewModelCore{
    
    func getFavAlbum() ->[Albums] {
        let result = self.manager.getFavAlbum()
        return result
    }
    
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    
    func getAlbums() {
        self.networkManager.getModelAlbum(url: NetworkParams.albumMusic.url){(result: Result<AlbumPage,NetworkError>)in
            switch result{
            case .success(let page):
                self.pageCount += 1
                self.albums.append(contentsOf: page.feed.results)
                for index in 0..<page.feed.results.count{
                    self.albums[index].Id = index
                    //self.selectFav.append(Favorite(Id: index, favoriteA: false))
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func makeFavorite(index: Int){
        self.favorites = self.manager.makeFavorite(fav: self.albums[index])
        self.manager.saveContext()
        self.favoriteArray = self.manager.fetchFavAlbum()
        
    }
    
    func deleteFavorite(){
        self.manager.deleteAllData("Albums")
    }
    
//    func deleteFavoriteByIndex(index: Int){
//
//    }
    
}

extension AlbumViewModel: AlbumViewModelAttributesFav{
   

    func id(for index: Int) -> Int? {
        guard index < self.count else{return nil}
        return self.selectFav[index].Id
    }
    
    func favoriteA(for index: Int) -> Bool? {
        guard index < self.count else{return nil}
        return self.selectFav[index].favoriteA
    }
    
}
extension AlbumViewModel: AlbumViewModelAttributes{
    
    var count: Int{
        return self.albums.count
    }
    
    func albumName(for index: Int) -> String? {
        guard index < self.count else{return nil}
        return self.albums[index].name
    }
    
    func AlbumArtist(for index: Int) -> String? {
        guard index < self.count else{return nil}
        return self.albums[index].artistName
    }
    
    func releaseDate(for index: Int) -> String? {
        guard index < self.count else{return nil}
        return self.albums[index].releaseDate
    }
    
    func genres(for index: Int) -> String? {
        guard index < self.count else{return nil}
        return self.albums[index].genres[0].name
    }
    
    func albumImage(for index: Int, completion: @escaping (Data?) -> Void) {
        guard index < self.count else {
            completion(nil)
            return
        }
        let imageAlbum = self.albums[index].artworkUrl100
        
        if let imageData = ImageCache.shared.getImageData(key: imageAlbum){
            completion(imageData)
            return
        }
        
        self.networkManager.getRawData(url: NetworkParams.albumImage(imageAlbum).url){ result in
            switch result{
            case .success(let imageData):
                ImageCache.shared.setImageData(data: imageData, key: imageAlbum)
                completion(imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}
