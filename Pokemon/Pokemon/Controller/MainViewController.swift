//
//  ViewController.swift
//  Superpokemonapp
//
//  Created by Consultant on 7/14/22.
//

import UIKit


class MainViewController: UIViewController {
    
    
    let network: NetworkManager = NetworkManager()
    var pokemons = [PokemonDetail]()
    var pokemonUrl: Pokemonapi?
    var currentPokemon = 0
    
    lazy var pokemontable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.dataSource = self
        table.delegate = self
        table.prefetchDataSource = self
        table.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reusedId)
        return table
        
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        super.viewDidLoad()
        self.requestPague()
        self.setTableView()
    }
    
    private func requestPague() {
          let myGroup = DispatchGroup()

          var urls: String?
          switch self.currentPokemon {
              case 0:
                  urls = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=30"
                  self.currentPokemon += 1
              case 1:
                  urls = self.pokemonUrl?.next
              case 2:
                  urls = self.pokemonUrl?.previous
              default:
                  return
          }
          DispatchQueue.main.async {
              self.network.getPokemonList(urlStrg: urls ?? "") { result in

                  switch result {
                      case .success(let list):
                          self.pokemonUrl = list
                          for pokemonResource in list.results {
                              myGroup.enter()

                              self.network.getPokemon(url: pokemonResource.url) { pokeResult in
                                  switch pokeResult {
                                      case .success(let pokemon):
                                          self.pokemons.append(pokemon)
                                        
                                          myGroup.leave()

                                      case .failure(let error):
                                          print("OOPS! We screwed up.")
                                          print(error)
                                  }
                              }
                          }
                          myGroup.notify(queue: .main) {
                              self.pokemontable.reloadData()
                          }
                      case .failure(let error):
                          print("OOPS! We screwed up.")
                          print(error)

                          self.presentNetworkErrorAlert(error: error)
                  }
              }
          }
      }
    
    func setTableView(){
        self.view.addSubview(self.pokemontable)
        self.pokemontable.bindToSuperView()
    }
    

}
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return  min(self.pokemons.count, 150)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reusedId, for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
      
        cell.configure(with: self.pokemons[indexPath.row])
        cell.layer.cornerRadius = 10
       
         return cell
    }
}
    
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
  
        let detailVC = DetailViewController()
        detailVC.configure(with: self.pokemons[indexPath.row])
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: PokemonCellErrorDelegate {
    func initiateErrorMsg(err: NetworkError) {
        self.presentNetworkErrorAlert(error: err)
    }
}

extension MainViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let lastIndexPath = IndexPath(row: self.pokemons.count-1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return }
       
        self.requestPague()
    }
    
}

