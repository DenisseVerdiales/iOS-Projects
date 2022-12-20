//
//  ViewModelCapable.swift
//  FriendlyChatExample
//
//  Created by Consultant on 8/1/22.
//

import Foundation

protocol ViewModelCapable {
    func bindUpdating(handler: @escaping () -> Void)
    func getNewMessages()
}
