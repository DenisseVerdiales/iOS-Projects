//
//  Animals.swift
//  BasicLayoutApp
//
//  Created by Denisse Verdiales on 07/07/22.
//

import Foundation

struct Animal {
    var image:String = "", name:String = "", type:String = "", info: String = ""
  
    
    init(image: String, name: String, type: String, info: String){
        self.image = image
        self.name = name
        self.type = type
        self.info = info
    }
}

struct itemAnimals {
    func animal() -> [Animal]{
   return [ Animal(image: "1", name: "Ankara", type: "a",
                                            info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "2", name: "Antalya", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "3", name: "Aydin", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "4", name: "Bodrum", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "5", name: "Canakkale", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "6", name: "Cappadocia", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "7", name: "Efes", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "8", name: "Eskisehir", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "9", name: "Fethiye", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "10", name: "Istanbul", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "11", name: "Izmir", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "12", name: "Mardin", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "13", name: "Nemrut", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "14", name: "Pamukkale", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "15", name: "Patara", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "16", name: "Rize", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "18", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "17", name: "Salda", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "19", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "20", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "21", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "22", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "23", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "24", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "25", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "26", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "27", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "28", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "29", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut."),
                                           Animal(image: "30", name: "Sumela", type: "a",
                                           info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.")]
    }
}
