//
//  AlbumTableViewCell.swift
//  iTunes
//
//  Created by Consultant on 7/23/22.
//

import UIKit
protocol CellDelegate: AnyObject {
    func onCellModelChange(cell: AlbumTableViewCell, model: selectColorFav)
}
class AlbumTableViewCell: UITableViewCell {
    weak var delegate: CellDelegate?
    static let reuseId = "\(AlbumTableViewCell.self)"
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
        label.textColor = .white
        
        return label
    }()
    
    lazy var artistLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Artist"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        return label
    }()
    
    lazy var favButton: UIButton = {
        let favButton = UIButton(frame: .zero)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.setBackgroundImage(self.dislikedImage, for: UIControl.State.normal)
        favButton.addTarget(self, action: #selector(ButtonPresented), for: .touchUpInside)
         
         return favButton
     }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var albums: AlbumViewModelType?
    var index: Int = 0
    
    func configure(album: AlbumViewModelType, index: Int){
        self.index = index
        self.albums = album

        self.titleLabel.text = album.albumName(for: index)
        self.artistLabel.text = album.AlbumArtist(for: index)
        album.albumImage(for: index){ imageData in
            guard let imageData = imageData else {return}
            DispatchQueue.main.async {
                self.imgAlbumView.image = UIImage(data: imageData)
            }
        }
        let favAlbum = self.albums?.getFavAlbum()
        
        for i in 0 ..< (favAlbum?.count ?? 0){
           
            if favAlbum?[i].name == self.albums?.albumName(for: self.index){
                self.updateColor(with: .liked)
            }else{
                self.updateColor(with: .disLiked)
            }
        }

    }
    
    func updateColor(with model: selectColorFav){
          switch model {
          case .liked:
              self.favButton.setBackgroundImage(self.likedImage, for: UIControl.State.normal)
              self.isLiked = true
          case .disLiked:
              self.favButton.setBackgroundImage(self.dislikedImage, for: UIControl.State.normal)
              self.isLiked = false
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
        
        if self.isLiked{
            delegate?.onCellModelChange(cell: self, model: .disLiked)
            favButton.setBackgroundImage(self.dislikedImage, for: UIControl.State.normal)
           self.albums?.deleteFavorite()
        }
        else{
            delegate?.onCellModelChange(cell: self, model: .liked)
            favButton.setBackgroundImage(self.likedImage, for: UIControl.State.normal)
            self.albums?.makeFavorite(index: self.index)
        }

      }
}
