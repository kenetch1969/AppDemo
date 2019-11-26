//
//  SingletonOperation.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/25/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit
import CoreData

class SingletonOperation {
    
    static let shared = SingletonOperation()
    
    private let appDelegate: AppDelegate?
    private let managerContext: NSManagedObjectContext?
    
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managerContext = appDelegate?.persistentContainer.viewContext
    }
    
    // MARK: - Basico
    func insert(title: String, genre: String, anio: String, url: String, favorite: Bool) -> Bool {
        if let context = self.managerContext {
            let pelicula = Peliculas(context: context)
            pelicula.title = title
            pelicula.genre = genre
            pelicula.anio = anio
            pelicula.url = url
            pelicula.favorite = favorite
            
            do {
                try context.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    func update(pelicula: Peliculas) -> Bool {
        if let context = self.managerContext {
            do {
                try context.save()
                return true
            } catch {
                return false
            }
        }
        
        return false
    }
    
    func delete(pelicula: Peliculas) -> Bool{
        if let context = self.managerContext {
            
            context.delete(pelicula)
            do {
                try context.save()
                return true
            } catch {
                return false
            }
        }
        
        return false
    }
    
    func fetchAllPeliculas (completion: (Bool, [Peliculas]) -> ()) {
        if let context = self.managerContext {
            let fetchOne: NSFetchRequest<Peliculas> = Peliculas.fetchRequest()
            
            do {
                let pelicula = try context.fetch(fetchOne)
                if pelicula.count > 0 {
                    completion(true, pelicula)
                 } else {
                    completion(false, pelicula)
                 }
            } catch {
               completion(false, [Peliculas]())
            }
        }
    }
    
    func fetchPelicula (title: String, completion: (Bool, Peliculas) -> ()) {
        if let context = self.managerContext {
            let fetchOne: NSFetchRequest<Peliculas> = Peliculas.fetchRequest()
            fetchOne.predicate = NSPredicate.init(format: "title = %@", title)
            
            do {
                let pelicula = try context.fetch(fetchOne)
                if pelicula.count > 0 {
                    completion(true, pelicula[0])
                } else {
                    completion(false, Peliculas(context: context))
                }
            } catch {
               completion(false, Peliculas())
            }
        }
    }
    
    func deleteAllData(entity: String, completion: (Bool) -> ()) {
       if let context = self.managerContext {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do {
            try context.execute(DelAllReqVar)
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
       } else {
        completion(false)
       }
    }
    
}
