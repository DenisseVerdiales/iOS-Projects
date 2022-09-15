//
//  ChatTableViewCell.swift
//  Messages
//
//  Created by Consultant on 8/3/22.
//

import UIKit
import BaronTalk

class ChatTableViewCell: UITableViewCell {

    static let reuseID = "\(ChatTableViewCell.self)"

    lazy var messageContent: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "message"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.right
        // label.textColor = .white

        return label
    }()
    
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(msg: Message){

        self.messageContent.text = msg.content

    }
    
    private func setUpUI(){
         self.contentView.backgroundColor = .clear
         
         let vStackView = UIStackView(frame: .zero)
         vStackView.translatesAutoresizingMaskIntoConstraints = false
         vStackView.spacing = 8
         vStackView.axis = .vertical
         vStackView.distribution = .fillEqually
         
         vStackView.addArrangedSubview(self.messageContent)
        
         
         self.contentView.addSubview(vStackView)
        vStackView.bindToSuperview()
         
     }
}
