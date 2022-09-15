//
//  ChatMessageTableViewCell.swift
//  Messages
//
//  Created by Consultant on 8/3/22.
//

import UIKit
import BaronTalk
class ChatMessageTableViewCell: UITableViewCell {
    static let reuseID = "\(ChatMessageTableViewCell.self)"
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    lazy var viewChatBackground: UIView = {
        let viewChatBackground = UIView()
        viewChatBackground.translatesAutoresizingMaskIntoConstraints = false
        viewChatBackground.layer.cornerRadius = 12
        
        return viewChatBackground
    }()
    
    lazy var messageContent: UILabel = {
        let label = UILabel()
        label.text = "message"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    var isInComing: Bool!{
        didSet{
            self.viewChatBackground.backgroundColor = isInComing ? .white : .orange
            self.messageContent.textColor = isInComing ? .black : .white
            
            if isInComing {
                self.leadingConstraint.isActive = false
                self.trailingConstraint.isActive = true
            }else{
                self.leadingConstraint.isActive = true
                self.trailingConstraint.isActive = false
            }
        }
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with msg: MessagesAttributes, index:Int ){
        self.messageContent.text = "\(msg.userSenderId(for: index) ?? "") \n\n \(msg.content(for: index) ?? "")"
  
    }
    
    private func setUpUI(){
        backgroundColor = .clear
        addSubview(self.viewChatBackground)
        addSubview(self.messageContent)
        self.messageContent.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        self.messageContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        self.messageContent.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        self.viewChatBackground.topAnchor.constraint(equalTo: self.messageContent.topAnchor, constant: -16).isActive = true
        self.viewChatBackground.leadingAnchor.constraint(equalTo: self.messageContent.leadingAnchor, constant: -16).isActive = true
        self.viewChatBackground.bottomAnchor.constraint(equalTo: self.messageContent.bottomAnchor, constant: 16).isActive = true
        self.viewChatBackground.trailingAnchor.constraint(equalTo: self.messageContent.trailingAnchor, constant: 16).isActive = true
      
        self.leadingConstraint = self.messageContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        self.leadingConstraint.isActive = false
        self.trailingConstraint = self.messageContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        self.trailingConstraint.isActive = true
         
     }
}
