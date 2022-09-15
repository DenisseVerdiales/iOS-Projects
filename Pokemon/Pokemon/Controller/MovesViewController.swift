//
//  MovesViewController.swift
//  Pokemon
//
//  Created by Consultant on 7/19/22.
//

import UIKit

class MovesViewController: UIViewController {

    var movesArr: PokemonDetail?
    
    
    lazy var movesTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.dataSource = self
        //table.delegate = self
        //table.prefetchDataSource = self
        table.backgroundColor = color(pokemonDetail: movesArr)
        table.register(MovesTableViewCell.self, forCellReuseIdentifier: MovesTableViewCell.reusedId)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
    }
    
    init(pokemonMoves: PokemonDetail){
       
        self.movesArr = pokemonMoves
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movesPokemon: PokemonDetail){
        self.movesArr = movesPokemon
    }
    
    func setTableView(){
        self.title = "Moves"
        self.view.backgroundColor = color(pokemonDetail: self.movesArr)
        self.view.addSubview(self.movesTable)
        self.movesTable.bindToSuperView()
    }

}
extension MovesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movesArr?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovesTableViewCell.reusedId, for: indexPath) as? MovesTableViewCell else {return UITableViewCell()}
        cell.backgroundColor = color(pokemonDetail: self.movesArr)
        cell.movesName.text = self.movesArr?.moves[indexPath.row].move.name
         return cell
    }
    
    
}
