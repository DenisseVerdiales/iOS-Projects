//
//  RickAndMortySwiftyUIApp.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import SwiftUI

@main
struct RickAndMortySwiftyUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(rickAndMortyListVM: RickAndMortyListViewModel())
        }
    }
}
