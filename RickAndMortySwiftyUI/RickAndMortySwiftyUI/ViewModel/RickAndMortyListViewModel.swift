//
//  RickAndMortyListViewModel.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import Foundation
import Combine

protocol RickAndMortyListViewModelType: ObservableObject{
    var rickAndMorty: [Results]{get}
    var isLoading: Bool {get}
    func requestRickAndMortyIfNeeded(index: Int)
}

class RickAndMortyListViewModel: RickAndMortyListViewModelType{
    
    private let networkService: NetworkService
    private var subs = Set<AnyCancellable>()
    @Published var rickAndMorty: [Results] = []
    var currentPage = 0
    @Published var isLoading: Bool = false
    
    init(network: NetworkService = NetworkManager()){
        self.networkService = network
        self.requestRickAndMortyIfNeeded(index: 0)
    }
    
    func requestRickAndMortyIfNeeded(index: Int) {
        guard index == (self.rickAndMorty.count - 1) || self.rickAndMorty.isEmpty else{return}
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.requestRickAndMorty()
        }
    }
    
    func requestRickAndMorty(){
        self.networkService.getModel(url: NetworkParams.character(self.currentPage + 1).url)
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                print(completion)
            } receiveValue: { [weak self] (page: PageResult) in
                self?.rickAndMorty.append(contentsOf: page.results)
                self?.currentPage = (self?.currentPage ?? 0) + 1
                self?.isLoading = false
            }.store(in: &self.subs)
    }
}
