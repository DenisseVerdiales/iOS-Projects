//
//  MainViewController.swift
//  FriendlyChatExample
//
//  Created by Marquis Kurt on 30/7/22.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    let messageMT = MessagesController()
    
    var messageArr: [Message] = []
    override func viewDidLoad() {
        
        self.messageMT.getContent(completion: { results in
           
           switch results {
               case .success(let Message):
                   for value in Message{
                       print(value.content)
                       self.messageArr.append(value)
                   }
                   
               case .failure(let error):
                   print("Error \(error)")
           }
         
      })
     
        
      super.viewDidLoad()

    }
    
    

}
