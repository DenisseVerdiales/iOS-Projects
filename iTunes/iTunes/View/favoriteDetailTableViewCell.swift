//
//  favoriteDetailTableViewCell.swift
//  iTunes
//
//  Created by Consultant on 7/26/22.
//

import UIKit
protocol CellFavDelegate: AnyObject {
    func onCellModelChange(cell: favoriteDetailTableViewCell, model: selectColorFav)
}
class favoriteDetailTableViewCell: UITableViewCell {
    weak var delegateFav: CellFavDelegate?
    static let reuseId = "\(favoriteDetailTableViewCell.self)"
    var isLiked: Bool = false
    let dislikedImage = UIImage(systemName: "heart")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let likedImage = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    
    lazy var imgAlbumView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "pok")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
       // label.textColor = .white
        
        return label
    }()
    
    lazy var artistLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Artist"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        //label.textColor = .white
        
        return label
    }()
    
    lazy var favButton: UIButton = {
        let favButton = UIButton(frame: .zero)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.setBackgroundImage(self.likedImage, for: UIControl.State.normal)
        favButton.addTarget(self, action: #selector(ButtonPresented), for: .touchUpInside)
         
         return favButton
     }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUpUI()

    }
    

    var albums: AlbumViewModelType?
    var favoriteAlbum: [Albums] = []
    var index: Int = 0
    
    func configure(album: [Albums], index: Int){
        self.index = index
        self.titleLabel.text = album[index].name
        self.artistLabel.text = album[index].artistName
        if let imageData = ImageCache.shared.getImageData(key: String(album[index].artworkUrl100 ?? "") ){
            self.imgAlbumView.image = UIImage(data: imageData)
        }
    }
    
    private func setUpUI(){
        
        let hStackViewFavButton = UIStackView(frame: .zero)
        hStackViewFavButton.translatesAutoresizingMaskIntoConstraints = false
        hStackViewFavButton.spacing = 8
        hStackViewFavButton.axis = .vertical
        hStackViewFavButton.distribution = .fill

        hStackViewFavButton.addArrangedSubview(self.favButton)
        
        let hStackViewFavIcon = UIStackView(frame: .zero)
        hStackViewFavIcon.translatesAutoresizingMaskIntoConstraints = false
        hStackViewFavIcon.spacing = 8
        hStackViewFavIcon.axis = .horizontal
        hStackViewFavIcon.distribution = .fill
        
        hStackViewFavIcon.addSubview(hStackViewFavButton)
    
           
        let hStackViewImg = UIStackView(frame: .zero)
        hStackViewImg.translatesAutoresizingMaskIntoConstraints = false
        hStackViewImg.spacing = 8
        hStackViewImg.axis = .horizontal
        hStackViewImg.distribution = .fill
           
        hStackViewImg.addArrangedSubview(self.imgAlbumView)
        hStackViewImg.addArrangedSubview(hStackViewFavIcon)
        
        let hStackViewLabel = UIStackView(frame: .zero)
        hStackViewLabel.translatesAutoresizingMaskIntoConstraints = false
        hStackViewLabel.spacing = 8
        hStackViewLabel.axis = .horizontal

        hStackViewLabel.addArrangedSubview(self.artistLabel)
        
        let hStackViewAlbumLabel = UIStackView(frame: .zero)
        hStackViewAlbumLabel.translatesAutoresizingMaskIntoConstraints = false
        hStackViewAlbumLabel.spacing = 8
        hStackViewAlbumLabel.axis = .horizontal

        hStackViewAlbumLabel.addArrangedSubview(self.titleLabel)
        
        let hStackViewGenreLabel = UIStackView(frame: .zero)
        hStackViewGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        hStackViewGenreLabel.spacing = 8
        hStackViewGenreLabel.axis = .horizontal
        
        
        let vStackViewContent = UIStackView(frame: .zero)
        vStackViewContent.translatesAutoresizingMaskIntoConstraints = false
        vStackViewContent.spacing = 8
        vStackViewContent.axis = .vertical

        vStackViewContent.addArrangedSubview(hStackViewImg)
        vStackViewContent.addArrangedSubview(hStackViewLabel)
        vStackViewContent.addArrangedSubview(hStackViewAlbumLabel)
        vStackViewContent.addArrangedSubview(hStackViewGenreLabel)
        
     
        self.imgAlbumView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.imgAlbumView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.favButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.favButton.heightAnchor.constraint(equalToConstant: 30).isActive = true


        self.contentView.addSubview(vStackViewContent)
        vStackViewContent.bindToSuperView()
   }
    
    @objc
    func ButtonPresented(sender: Any){
        
        self.albums?.deleteFavorite()
        
        
    }

}
