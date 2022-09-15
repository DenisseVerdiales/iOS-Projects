//
//  ChatViewController.swift
//  Messages
//
//  Created by Consultant on 8/2/22.
//

import UIKit
import BaronTalk

class ChatViewController: UIViewController {

    let messageC = BaronTalk.MessagesController()
    var messageArr: [Message] = []
    var messageArrayByDate = [[Message]]()
    var userInfo: userInfo?
    //let messageType: MessageModel?
    lazy var table: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.register(ChatMessageTableViewCell.self, forCellReuseIdentifier: ChatMessageTableViewCell.reuseID)
        table.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        return table
    }()
    
    
    lazy var txtChat: UITextField = {
       let txtChat = UITextField()
        txtChat.translatesAutoresizingMaskIntoConstraints = false
        txtChat.placeholder = "Enter message"
        
        return txtChat
    }()
    
    lazy var btnSend: UIButton = {
        let btnSend = UIButton(frame: .zero)
        btnSend.translatesAutoresizingMaskIntoConstraints = false
        btnSend.backgroundColor = .systemTeal
        btnSend.setTitle("Send", for: .normal)
        btnSend.setTitleColor(.white, for: .normal)
        btnSend.layer.cornerRadius = 3
        btnSend.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btnSend.addTarget(self, action: #selector(btnSendMessage), for: .touchUpInside)

        return btnSend
    }()
    
    
    init(userInfo: userInfo){
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
       
        view.backgroundColor = .white
        
        navigationItem.title = "Messages"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(btnLogOut))
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        
        self.setUpUI()
        
        self.messageC.bindUpdating {
           DispatchQueue.main.async {
               self.table.reloadData()
           }

       }

        self.messageC.getData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func setUpUI(){
   
        self.view.addSubview(self.table)
        self.view.addSubview(self.txtChat)
        self.view.addSubview(self.btnSend)
        self.table.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.table.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.table.bottomAnchor.constraint(equalTo: self.txtChat.topAnchor, constant: -8).isActive = true
      //  self.table.heightAnchor.constraint(equalToConstant: 500).isActive = true
        self.table.bottomAnchor.constraint(equalTo: self.btnSend.topAnchor, constant: -8).isActive = true
      
        self.txtChat.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.txtChat.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.txtChat.topAnchor.constraint(equalTo: self.table.bottomAnchor, constant: 8).isActive = true
        self.txtChat.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.txtChat.heightAnchor.constraint(equalToConstant: 44).isActive = true

      //  self.btnSend.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.btnSend.trailingAnchor.constraint(equalTo: self.txtChat.trailingAnchor, constant: -8).isActive = true
        self.btnSend.topAnchor.constraint(equalTo: self.table.bottomAnchor, constant: 8).isActive = true
       self.btnSend.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -8).isActive = true
        self.btnSend.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.btnSend.heightAnchor.constraint(equalToConstant: 44).isActive = true
//
         
     }
    
    func test() async{
        
        let groupDic = Dictionary(grouping: self.messageC.messages) { (msg) -> DateComponents in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let d = dateFormatter.date(from: msg.timestamp)
            let date = Calendar.current.dateComponents([.day, .year, .month], from: (d ?? Date()))

            return date
        }
        
    
        print("X: \(groupDic)")
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(self.view.frame.origin.y)
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                
            }
        }

    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(self.view.frame.origin.y)
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc
    func btnSendMessage(){
        guard let message = txtChat.text else {return}
        guard let userId = self.userInfo?.userId else {return}
        
        let result: ResultSend? = self.messageC.sendMessage(message: message, userSenderId: userId)
        self.txtChat.text = ""
        
    }
    @objc
    func btnLogOut(){
        AuthHandler.logOut(completion: {}, error: {error in})
        
        let strongSelf = self
        strongSelf.navigationController?.dismiss(animated: true)
    }
}

extension ChatViewController: UITableViewDataSource{
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//       // print(self.messageArrayByDate.count)
//        return self.messageC.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section: \(section)"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = .none
        return self.messageC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageTableViewCell.reuseID, for: indexPath) as? ChatMessageTableViewCell else {
           return UITableViewCell()
       }
       // cell.backgroundColor = .green
        //cell.messageContent.numberOfLines = 0
       // cell.messageContent.text = self.messageArrayByDate[indexPath.section][indexPath.row].content
        cell.isInComing =  self.messageC.userSenderId(for: indexPath.row) == self.userInfo?.userId ? true : false
        
        cell.configure(with: self.messageC, index: indexPath.row)
        
        return cell
    }
    
    
}
