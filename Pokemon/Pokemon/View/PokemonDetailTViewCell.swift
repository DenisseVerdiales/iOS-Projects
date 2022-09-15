//
//  PokemonDetailTViewCell.swift
//  Pokemon
//
//  Created by Consultant on 7/18/22.
//

import UIKit

class PokemonDetailTViewCell: UITableViewCell {

    static let reusedId = "\(PokemonTableViewCell.self)"
    var pokemonDetail: PokemonDetail?
    let NetManager = NetworkManager()
    
    lazy var progImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "pok")
        
        return imageView
    }()
    
    lazy var progTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = .white
        label.textColor = color(pokemonDetail: self.pokemonDetail)
        label.shadowColor = .black
        label.font = label.font.withSize(20)
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 10
        label.text = "Pokemon Name"
        
        return label
    }()
    
    lazy var progAbilitieLabel0: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = ""
        label.backgroundColor = .white
        label.layer.borderWidth = 2.0
        
        return label
    }()
    
    lazy var progAbilitieLabel1: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = ""
        label.backgroundColor = .white
        label.layer.borderWidth = 2.0
        
        return label
    }()
    
    
    lazy var progBottomLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.text = "Pokemon info info info"
        
        return label
    }()
    lazy var progressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 1"
        
        return label
    }()
    lazy var progressLabel2: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 2"
        
        return label
    }()
    lazy var progressLabel3: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 3"
        
        return label
    }()
    lazy var progressLabel4: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 4"
        
        return label
    }()
    lazy var progressLabel5: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 5"
        
        return label
    }()
    lazy var progressLabel6: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 6"
        
        return label
    }()
    lazy var progProgress: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress2: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress3: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress4: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress5: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress6: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        self.setUpUI()
    }
    
    
    func configure(with pokDetail: PokemonDetail) {
      
        self.pokemonDetail = pokDetail
        let url1s = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokDetail.id).png")
                              
        self.NetManager.fetchImageData(urlStr: url1s) { result in
           DispatchQueue.main.async{ [self] in
               if let data = result{
                   self.progImageView.image = UIImage(data: data)
                   self.progTopLabel.text = "\(self.pokemonDetail?.name ?? "") No. \(self.pokemonDetail?.id ?? 0)"
                
                   self.progressLabel.text = "\(pokDetail.stats[0].stat.name) : \(pokDetail.stats[0].baseStat)"
                   self.progressLabel2.text = "\(pokDetail.stats[1].stat.name) : \(pokDetail.stats[1].baseStat)"
                   self.progressLabel3.text = "\(pokDetail.stats[2].stat.name) : \(pokDetail.stats[2].baseStat)"
                   self.progressLabel4.text = "\(pokDetail.stats[3].stat.name) : \(pokDetail.stats[3].baseStat)"
                   self.progressLabel5.text = "\(pokDetail.stats[4].stat.name) : \(pokDetail.stats[4].baseStat)"
                   self.progressLabel6.text = "\(pokDetail.stats[5].stat.name) : \(pokDetail.stats[5].baseStat)"
                   
                   self.progProgress.progress = pokDetail.stats[0].baseStat * 0.01
                   self.progProgress2.progress = pokDetail.stats[1].baseStat * 0.01
                   self.progProgress3.progress = pokDetail.stats[2].baseStat * 0.01
                   self.progProgress4.progress = pokDetail.stats[3].baseStat * 0.01
                   self.progProgress5.progress = pokDetail.stats[4].baseStat * 0.01
                   self.progProgress6.progress = pokDetail.stats[5].baseStat * 0.01
                   
                   self.progBottomLabel.text = "Abilities: "
                   for index in 0..<pokDetail.abilities.count {
                       self.progBottomLabel.text! += pokDetail.abilities[index].ability.name + " ,"
                   }
                   
               }

           }
       }
        
    }
    
    private func setUpUI(){
        
        let vImgEmptyStackView = UIStackView(frame: .zero)
        vImgEmptyStackView.translatesAutoresizingMaskIntoConstraints = false
        vImgEmptyStackView.spacing = 0
        vImgEmptyStackView.axis = .horizontal
        vImgEmptyStackView.backgroundColor = .systemRed
        vImgEmptyStackView.layer.cornerRadius = 10
        vImgEmptyStackView.backgroundColor = color(pokemonDetail: self.pokemonDetail)

        
        let vImgStackView = UIStackView(frame: .zero)
        vImgStackView.translatesAutoresizingMaskIntoConstraints = false
        vImgStackView.spacing = 0
        vImgStackView.axis = .horizontal
        vImgStackView.backgroundColor = color(pokemonDetail: self.pokemonDetail)
        vImgEmptyStackView.layer.cornerRadius = 10

        vImgStackView.addArrangedSubview(self.progImageView)
        
        let vEmptyStackView = UIStackView(frame: .zero)
        vEmptyStackView.translatesAutoresizingMaskIntoConstraints = false
        vEmptyStackView.spacing = 10
        vEmptyStackView.axis = .vertical
        vEmptyStackView.distribution = .equalCentering
        vEmptyStackView.backgroundColor = .white
        vEmptyStackView.trailingAnchor.constraint(equalTo: vEmptyStackView.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        

        vEmptyStackView.addArrangedSubview(self.progProgress)
        vEmptyStackView.addArrangedSubview(self.progProgress2)
        vEmptyStackView.addArrangedSubview(self.progProgress3)
        vEmptyStackView.addArrangedSubview(self.progProgress4)
        vEmptyStackView.addArrangedSubview(self.progProgress5)
        vEmptyStackView.addArrangedSubview(self.progProgress6)
        
        let vProgressLabelStackView = UIStackView(frame: .zero)
        vProgressLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        vProgressLabelStackView.spacing = 10
        vProgressLabelStackView.axis = .vertical
        vProgressLabelStackView.distribution = .equalCentering
        vProgressLabelStackView.backgroundColor = .white
        
        vProgressLabelStackView.addArrangedSubview(self.progressLabel)
        vProgressLabelStackView.addArrangedSubview(self.progressLabel2)
        vProgressLabelStackView.addArrangedSubview(self.progressLabel3)
        vProgressLabelStackView.addArrangedSubview(self.progressLabel4)
        vProgressLabelStackView.addArrangedSubview(self.progressLabel5)
        vProgressLabelStackView.addArrangedSubview(self.progressLabel6)
        
        let vProgressStackView = UIStackView(frame: .zero)
        vProgressStackView.translatesAutoresizingMaskIntoConstraints = false
        vProgressStackView.spacing = 10
        vProgressStackView.alignment = .center
        vProgressStackView.axis = .horizontal
        vProgressStackView.backgroundColor = .white
        
     
        vProgressStackView.addArrangedSubview(vProgressLabelStackView)
        vProgressStackView.addArrangedSubview(vEmptyStackView)
        
        let vProgressLabelStackView6 = UIStackView(frame: .zero)
        vProgressLabelStackView6.translatesAutoresizingMaskIntoConstraints = false
        vProgressLabelStackView6.spacing = 0
        vProgressLabelStackView6.axis = .horizontal
        vProgressLabelStackView6.distribution = .equalSpacing
        vProgressLabelStackView6.backgroundColor = .white
        
        vProgressLabelStackView6.addArrangedSubview(self.progTopLabel)
        
        
        let vLabelTypeStackView3 = UIStackView(frame: .zero)
        vLabelTypeStackView3.translatesAutoresizingMaskIntoConstraints = false
        vLabelTypeStackView3.spacing = 0
        vLabelTypeStackView3.axis = .horizontal
        vLabelTypeStackView3.distribution = .equalSpacing
        vLabelTypeStackView3.backgroundColor = .white

        
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 0
        vStackView.axis = .vertical
        vStackView.backgroundColor = .white
        
      
        vStackView.addArrangedSubview(vProgressLabelStackView6)
        vStackView.addArrangedSubview(vLabelTypeStackView3)
        vStackView.addArrangedSubview(vProgressStackView)
        vStackView.addArrangedSubview(self.progBottomLabel)
        
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.spacing = 10
        hStackView.axis = .vertical
        
        hStackView.addArrangedSubview(vImgStackView)
        hStackView.addArrangedSubview(vStackView)
        
      
    
        self.progImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.progImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.progTopLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.progTopLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true

        self.progBottomLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.progBottomLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.progProgress.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.progProgress.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.progProgress2.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress3.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.progProgress3.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress4.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.progProgress4.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress5.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.progProgress5.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress6.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.progProgress6.widthAnchor.constraint(equalToConstant: 110).isActive = true

        
        self.contentView.addSubview(hStackView)
        hStackView.bindToSuperViewDetail()
      }

}
