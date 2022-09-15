//
//  NetTableViewCell.swift
//  IntroToNetworkingAssignment
//
//  Created by Denisse Verdiales on 11/07/22.
//

import UIKit

class NetTableViewCell: UITableViewCell {
    
    static let reuseID = "\(NetTableViewCell.self)"
    
    lazy var netImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var netLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 15.0
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()
        self.callNetwork()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

    }

    
    private func setUpUI(){
        self.contentView.backgroundColor = .clear
        
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        
        vStackView.addArrangedSubview(self.netLabel)
        
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.spacing = 8
        hStackView.axis = .horizontal
        
        hStackView.addArrangedSubview(self.netImageView)
        hStackView.addArrangedSubview(vStackView)
        
        self.netImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.netImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.contentView.addSubview(hStackView)
        hStackView.bindToSuperview()
        
    }
    static var urlString:String?
    
    @objc
      func callNetwork() {
          let url = URL(string: "https://picsum.photos/200/300")
          
        NetworkManager.shared.getData(url: url){ data, response in
              DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                let res = httpResponse?.value(forHTTPHeaderField: "picsum-id")
                let urlcell = response.url
                NetTableViewCell.urlString = urlcell?.absoluteString ?? ""
                if let data = data{
                    self.netImageView.image = UIImage(data: data)
                    self.netLabel.text = "ID:  \(res ?? "")"
                }
                      
              }
          }
      }
    
}
