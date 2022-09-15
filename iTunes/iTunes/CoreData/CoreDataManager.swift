//
//  CoreDataManager.swift
//  iTunes
//
//  Created by Consultant on 7/22/22.
//

import Foundation
import CoreData

class CoreDataManager{
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iTunes")
        container.loadPersistentStores{(description, error) in
            if let _ = error {
                fatalError("Error")
            }
        }
        return container
    }()
    
    func saveContext(){
        let context = self.persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
    
    func fetchFavAlbum() -> [Albums]?{
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<Albums> = Albums.fetchRequest()
        
        do{
            let results = try context.fetch(request)
            print(results)
            return results
           
        }catch{
            print(error)
        }
        return nil
    }
    
    func makeFavorite(fav: Results) -> Albums?{
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Albums", in: context) else {return nil}
        
        let favorite = Albums(entity: entity, insertInto: context)
        
        favorite.artworkUrl100 = fav.artworkUrl100
        favorite.artistName = fav.artistName
        favorite.releaseDate = fav.releaseDate
        favorite.genres = fav.genres[0].name
        favorite.name = fav.name
        
        return favorite
    }
    
    func getFavAlbum() -> [Albums]{
        var arrayFavorite: [Albums] = []
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<Albums> = Albums.fetchRequest()
        request.predicate = NSPredicate(format: "name != nil")
        
        
        do{
            arrayFavorite = try context.fetch(request)

        }catch{
            print(error)
        }
        return arrayFavorite
    }
    
   
    
    func deleteAllData(_ entity:String) {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
                
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
        self.saveContext()
    }
    
    func deleteDataByIndex(_ entity:String) {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
                
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
        self.saveContext()
    }
}
