//
//  RickAndMortyDetailView.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import SwiftUI

struct RickAndMortyDetailView<T: RickAndMortyListViewModelType>: View{
    @ObservedObject var rickAndMortyVM: T
    let index: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View{
        VStack{
            RickAndMortyView(rickAndMortyListVM: self.rickAndMortyVM, index: index)
                .padding([.top, .bottom, .trailing], 8)
            Text("Status: \(self.rickAndMortyVM.rickAndMorty[index].species)")
            Text("Origin: \(self.rickAndMortyVM.rickAndMorty[index].origin.name)")
            Text("Location: \(self.rickAndMortyVM.rickAndMorty[index].location.name)")
            Text("Species: \(self.rickAndMortyVM.rickAndMorty[index].species)")
               
        }
    }
}

struct RickAndMortyDetailView_Previews: PreviewProvider{
    static var previews: some View{
        RickAndMortyDetailView(rickAndMortyVM: RickAndMortyListViewModel(), index: 0)
    }
}
