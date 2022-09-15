//
//  RickAndMortyView.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import SwiftUI

struct RickAndMortyView<T: RickAndMortyListViewModelType>: View{
    
    @ObservedObject var rickAndMortyListVM: T
    let index: Int
    
    var body: some View{
        HStack{
            AsyncImage(url: NetworkParams.image(self.rickAndMortyListVM.rickAndMorty[index].image).url){
                realImage in
                realImage
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
            }placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100, alignment: .center)
            }
            VStack{
                
                   // .padding([.top, .bottom, .trailing], 8)
                Text("Name: \(rickAndMortyListVM.rickAndMorty[index].name)")
                Text("Gender: \(rickAndMortyListVM.rickAndMorty[index].gender)")
                   // .padding([.top, .bottom, .trailing], 8)
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
    }
}

struct RickAndMortyView_Previews: PreviewProvider{
    static var previews: some View {
        RickAndMortyView(rickAndMortyListVM: RickAndMortyListViewModel(), index: 0)
    }
}
