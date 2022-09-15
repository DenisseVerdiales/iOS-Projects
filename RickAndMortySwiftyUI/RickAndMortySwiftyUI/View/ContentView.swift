//
//  ContentView.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import SwiftUI

struct ContentView<T: RickAndMortyListViewModelType>: View {
    
    @ObservedObject var rickAndMortyListVM: T
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Rick And Morty")
                
                List{
                    ForEach(0..<self.rickAndMortyListVM.rickAndMorty.count, id: \.self){ index in
                        NavigationLink(destination: RickAndMortyDetailView(rickAndMortyVM: rickAndMortyListVM, index: index)){
                            RickAndMortyView(rickAndMortyListVM: self.rickAndMortyListVM, index: index)
                                .onAppear{
                                    self.rickAndMortyListVM.requestRickAndMortyIfNeeded(index: index)
                                }
                        }
                    }
                    if self.rickAndMortyListVM.isLoading{
                        ProgressView()
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView(rickAndMortyListVM: RickAndMortyListViewModel())
    }
}
