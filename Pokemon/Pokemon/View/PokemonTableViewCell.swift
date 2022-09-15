//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Consultant on 7/15/22.
//

import UIKit

protocol PokemonCellErrorDelegate: AnyObject {
    func initiateErrorMsg(err: NetworkError)
}
class PokemonTableViewCell: UITableViewCell {

    static let reusedId = "\(PokemonTableViewCell.self)"
    var delegate: PokemonCellErrorDelegate?
    
    let network = NetworkManager()
    lazy var PokeImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
      //  imageView.backgroundColor = .white
        imageView.image = UIImage(named: "pok")
        imageView.layer.cornerRadius = 50
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.0
        return imageView
    }()
    lazy var pokename: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "Pokemon Name"
        label.layer.borderColor = UIColor.systemGray5.cgColor
        label.layer.borderWidth = 1.0
        //label.textColor = .white
        
        return label
    }()
    lazy var PokeType: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.numberOfLines = 0
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.text = ""
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1.0
        return label

    }()
    

    var pokemons: PokemonDetail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUpUI()
    }
 
    private func setUpUI(){
        
        let hStack = UIStackView(axis: .horizontal, spacing: 8, distribution: .fill)
        let vStackRight = UIStackView(axis: .vertical, spacing: 8, distribution: .fill)
        let vStackLeft = UIStackView(axis: .vertical, spacing: 8, distribution: .fill)
        
        let rightBufferTop = UIView.createBufferView()
        let rightBufferBottom = UIView.createBufferView()
        
        vStackRight.addArrangedSubview(rightBufferTop)
        vStackRight.addArrangedSubview(self.pokename)
        vStackRight.addArrangedSubview(self.PokeType)
        vStackRight.addArrangedSubview(rightBufferBottom)
        
        rightBufferTop.heightAnchor.constraint(equalTo: rightBufferBottom.heightAnchor).isActive = true
        
        
        let leftBufferTop = UIView.createBufferView()
        let leftBufferBottom = UIView.createBufferView()
        
        vStackLeft.addArrangedSubview(leftBufferTop)
        vStackLeft.addArrangedSubview(self.PokeImage)
        vStackLeft.addArrangedSubview(leftBufferBottom)
        
        hStack.addArrangedSubview(vStackLeft)
        hStack.addArrangedSubview(vStackRight)
        self.contentView.addSubview(hStack)
        
        hStack.bindToSuperView()
    }
    

    func configure(with pokDetail: PokemonDetail) {

        self.pokename.text = "Name: \(pokDetail.name) No. \(pokDetail.id)"
        self.PokeType.text = " Type: "
        for index in 0..<pokDetail.types.count {
            self.PokeType.text! += pokDetail.types[index].type.name +  " ,"
        }
    
        self.PokeType.backgroundColor =  color(pokemonDetail: pokDetail)
        self.PokeImage.backgroundColor = color(pokemonDetail: pokDetail)
        self.pokename.layer.borderColor = colorBorder(pokemonDetail: pokDetail)

        if let imageData = ImageCache.shared.getImageData(key: "\(pokDetail.id)") {
            print("Image found in cache")
            self.PokeImage.image = UIImage(data: imageData)
            return
        }
       // let url1s = URL(string: pokemon.sprites.frontDefault)
                       
        network.fetchImageData1(urlStr: pokDetail.sprites.frontDefault) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    print("Image pulled from network")
                    ImageCache.shared.setImageData(data: imageData, key: "\(pokDetail.id)")

                    if pokDetail.id == (self.pokemons?.id ?? -1) {
                        self.PokeImage.image = UIImage(data: imageData)
                    }
                }
            case .failure(let error):
                print(error)
                self.delegate?.initiateErrorMsg(err: error)
                
            }
        }

    }
    
}
