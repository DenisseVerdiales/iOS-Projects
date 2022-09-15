//
//  RickAndMortyViewModel.swift
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

import UIKit

@objcMembers
class RickAndMortyViewModel: NSObject{
    
    private let networkManager: NetworkManager
    private var pageNumber: NSInteger = 0
    private var rick: [RickAndMorty] = []{
        didSet{
            self.updateHandler?()
        }
    }
    
    private var currentPage: PageResult?
    private var updateHandler: (() -> Void)?
    
    @objc
    init(networkManager: NetworkManager = NetworkManager.sharedInstance()){
        self.networkManager = networkManager
    }
    
    @objc
    func bind(updateHandler: @escaping () -> Void){
        self.updateHandler = updateHandler
    }
    
    @objc
    func fetchRickAndMortyPage(){
       
        self.pageNumber = pageNumber + 1
        
        self.networkManager.fetchRick(withPageNumber: pageNumber){ [weak self](pageResultReq: PageResult?)
            in
            guard let rickResult = pageResultReq?.rickAndMorty as? [RickAndMorty] else{return}
            self?.rick.append(contentsOf: rickResult)
        }
    }
    
    var count: Int{
        return self.rick.count
    }
    
    func name(for index: Int) -> String?{
        guard index < self.rick.count else {return nil}
        return self.rick[index].name
        
    }
    
    func status(for index: Int) -> String?{
        guard index < self.rick.count else {return nil}
        return self.rick[index].status
    }
    
    func gender(for index: Int) -> String?{
        guard index < self.rick.count else {return nil}
        return self.rick[index].gender
    }
    
    func species(for index: Int) -> String?{
        guard index < self.rick.count else {return nil}
        return self.rick[index].species
    }
    
    func image(for index: Int, completion: @escaping (UIImage?) -> Void){
        guard index < self.rick.count else{
            completion(nil)
            return
        }
        
        self.networkManager.fetchImage(with: self.rick[index].image){(image: UIImage?)in
            completion(image)
        }
    }
}


