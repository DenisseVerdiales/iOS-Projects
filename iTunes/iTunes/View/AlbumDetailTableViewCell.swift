//
//  AlbumDetailTableViewCell.swift
//  iTunes
//
//  Created by Consultant on 7/24/22.
//

import UIKit

class AlbumDetailTableViewCell: UITableViewCell {

    static let reuseId = "\(AlbumDetailTableViewCell.self)"
    
    var isLiked: Bool = false
    let unlikedImage = UIImage(systemName: "heart")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let likedImage = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    
    lazy var imgAlbumDetailView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.systemYellow.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.image = UIImage(named: "pok")
        return imageView
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        return label
    }()
    
    lazy var genresLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        return label
    }()
    
    lazy var favButton: UIButton = {
        let favButton = UIButton(frame: .zero)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.setBackgroundImage(self.unlikedImage, for: UIControl.State.normal)
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
        super.setSelected(false, animated: animated)

    }
    
    func configure(album: AlbumViewModelType, index: Int) {
        
        self.genresLabel.text = "Gender: \(album.genres(for: index) ?? "")"
        self.artistNameLabel.text = "Artist: \(album.AlbumArtist(for: index) ?? "")"
        self.albumNameLabel.text = "Album: \(album.albumName(for: index) ?? "")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let releseDate = dateFormatter.date(from: album.releaseDate(for: index) ?? "") else {return}
        
        dateFormatter.dateFormat = "MMMM d, y"
        let releseDateString = dateFormatter.string(from: releseDate)
        self.releaseDateLabel.text = "Relese Date: \(releseDateString)"
       
        album.albumImage(for: index){imgData in
            guard let imgData = imgData else { return }
            
            DispatchQueue.main.async {
                self.imgAlbumDetailView.image = UIImage(data: imgData)
            }
        }
    }
    
    
    private func setUpUI(){
        let hStackViewFavButton = UIStackView(frame: .zero)
        hStackViewFavButton.translatesAutoresizingMaskIntoConstraints = false
        hStackViewFavButton.spacing = 8
        hStackViewFavButton.axis = .vertical
        hStackViewFavButton.distribution = .fill
        
        let rightBufferTop = UIView.createBufferView()
        let rightBufferBottom = UIView.createBufferView()

        hStackViewFavButton.addArrangedSubview(rightBufferTop)
        hStackViewFavButton.addArrangedSubview(self.favButton)
        hStackViewFavButton.addArrangedSubview(rightBufferBottom)
    
        rightBufferTop.heightAnchor.constraint(equalTo: rightBufferBottom.heightAnchor).isActive = true
           
        let hStackViewImg = UIStackView(frame: .zero)
        hStackViewImg.translatesAutoresizingMaskIntoConstraints = false
        hStackViewImg.spacing = 8
        hStackViewImg.axis = .horizontal
        hStackViewImg.distribution = .fill
           
        hStackViewImg.addArrangedSubview(self.imgAlbumDetailView)
        hStackViewImg.addArrangedSubview(hStackViewFavButton)
        
        let hStackViewLabel = UIStackView(frame: .zero)
        hStackViewLabel.translatesAutoresizingMaskIntoConstraints = false
        hStackViewLabel.spacing = 8
        hStackViewLabel.axis = .horizontal

        hStackViewLabel.addArrangedSubview(self.artistNameLabel)
        
        let hStackViewAlbumLabel = UIStackView(frame: .zero)
        hStackViewAlbumLabel.translatesAutoresizingMaskIntoConstraints = false
        hStackViewAlbumLabel.spacing = 8
        hStackViewAlbumLabel.axis = .horizontal

        hStackViewAlbumLabel.addArrangedSubview(self.albumNameLabel)
        
        let hStackViewGenreLabel = UIStackView(frame: .zero)
        hStackViewGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        hStackViewGenreLabel.spacing = 8
        hStackViewGenreLabel.axis = .horizontal

        hStackViewGenreLabel.addArrangedSubview(self.genresLabel)
        
        let hStackViewReleseLabel = UIStackView(frame: .zero)
        hStackViewReleseLabel.translatesAutoresizingMaskIntoConstraints = false
        hStackViewReleseLabel.spacing = 8
        hStackViewReleseLabel.axis = .horizontal

        hStackViewReleseLabel.addArrangedSubview(self.releaseDateLabel)
        
        
        let vStackViewContent = UIStackView(frame: .zero)
        vStackViewContent.translatesAutoresizingMaskIntoConstraints = false
        vStackViewContent.spacing = 8
        vStackViewContent.axis = .vertical

        vStackViewContent.addArrangedSubview(hStackViewImg)
        vStackViewContent.addArrangedSubview(hStackViewLabel)
        vStackViewContent.addArrangedSubview(hStackViewAlbumLabel)
        vStackViewContent.addArrangedSubview(hStackViewGenreLabel)
        vStackViewContent.addArrangedSubview(hStackViewReleseLabel)
        

        self.imgAlbumDetailView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        self.imgAlbumDetailView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        self.favButton.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.favButton.heightAnchor.constraint(equalToConstant: 30).isActive = true


        self.contentView.addSubview(vStackViewContent)
        vStackViewContent.bindToSuperView()
   }
    @objc
      func ButtonPresented(){
          self.isLiked = !self.isLiked
          self.favButton.setBackgroundImage(self.isLiked ? self.likedImage : self.unlikedImage, for: UIControl.State.normal)
      }

}
