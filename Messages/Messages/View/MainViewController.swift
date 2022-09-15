//
//  MainViewController.swift
//  Messages
//
//  Created by Consultant on 8/4/22.
//

import UIKit
import FirebaseAuth
class MainViewController: UIViewController {
    private let tableView: UITableView = {
            let table = UITableView()
            table.backgroundColor = .white

            return table
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    
    private func validateAuth(){
       
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LogInViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }else{
            
            let vc = ChatViewController(userInfo: userInfo(userId: "\(UserDefaults() )"))
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
        }
 
}

    

    


  
