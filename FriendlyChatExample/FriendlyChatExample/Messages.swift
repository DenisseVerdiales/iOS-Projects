//
//  Messages.swift
//  FriendlyChatExample
//
//  Created by Consultant on 8/1/22.
//

import Foundation
import Firebase

enum NetworkError: Error {
    case dataFailure
}

extension NetworkError: LocalizedError{
    public var errorDescription: String? {
        switch self {
            case .dataFailure:
                return NSLocalizedString("The data is empty or corrupted", comment: "Data Failure")
        }
    }
}

protocol MessageModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getContent(completion: @escaping (Result<[Message], NetworkError>) -> Void)
    func sendMessage(message: String, userSenderId: Int)
    func getMessages() -> [Message]
}

protocol MessagesAttributes{
    var count: Int {get}
    func content(for index: Int) -> String?
    func timestamp(for index: Int) -> String?
    func messageId(for index: Int) -> String?
    func userSenderId(for index: Int) -> Int?
}

typealias MessageModelType = MessageModelCore & MessagesAttributes

class MessagesController{
    typealias UpdateType = () -> Void
    var messages: [Message] = [] {
        didSet{
            updateHandler?()
        }
    }

    private var updateHandler: UpdateType?
    
    public init() {}
}
extension MessagesController: MessagesAttributes{
    
    var count: Int{
           return self.messages.count
    }
    
    func content(for index: Int) -> String? {
          guard index < self.count else{return nil}
        return self.messages[index].content
    }
    
    func timestamp(for index: Int) -> String? {
          guard index < self.count else{return nil}
        return self.messages[index].timestamp
    }
    
    func messageId(for index: Int) -> String? {
          guard index < self.count else{return nil}
        return self.messages[index].messageId
    }
    
    func userSenderId(for index: Int) -> Int? {
          guard index < self.count else{return nil}
        return self.messages[index].userSenderId
    }
}

extension MessagesController: MessageModelCore{
    
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }

    func getMessages() -> [Message] {
        return self.messages
    }
    
    func getContent(completion: @escaping (Result<[Message], NetworkError>) -> Void){
    
        let ref = Database.database().reference().child("messages")
        ref.observeSingleEvent(of: .value, with: {snapshot in
   
            for child in snapshot.children{
                let snap = child as? DataSnapshot
                guard let dict = snap?.value as? [String: Any] else{return completion(.failure(.dataFailure))}
                
                let content = dict["content"] as? String ?? ""
                let messageId = dict["messageId"] as? String ?? ""
                let timestamp = dict["timestamp"] as? String ?? ""
                let userSenderId = dict["userSenderId"] as? Int ?? 0


                self.messages.append(Message(content: content, timestamp: timestamp, messageId: messageId, userSenderId: userSenderId))
                

            }
            completion(.success(self.messages))
            
        })
      
    }
    
    func sendMessage(message: String, userSenderId: Int){
        let dateMessage = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyyHHmmss"
        let idDate = dateFormatter.string(from: dateMessage)
        let sms = Database.database().reference().child("messages").child(idDate)
           
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        
            let postObject = [
                "content": message,
                "timestamp": dateFormatter.string(from: dateMessage),
                "messageId": idDate,
                "userSenderId": userSenderId
            ] as [String: Any]

            sms.setValue(postObject, withCompletionBlock: { error, ref in
              if error == nil {
                  print("Error")
              } else {
                  
              }
            })
    }
}

struct Message {
    var content: String
    var timestamp: String
    var messageId: String
    var userSenderId: Int

    init(content: String, timestamp: String, messageId: String, userSenderId: Int){
        self.content = content
        self.timestamp = timestamp
        self.messageId = messageId
        self.userSenderId = userSenderId
    }

    
}


