//
//  ShowMovieTableViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/13/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit
import CoreData

class ShowMovieTableViewController: UITableViewController {
    
    private var movies = [Peliculas]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //self.movies = [Movies(), Movies(), Movies()]
        self.movies = query()
    }
    
    // MARK: - Recuperar movies de la entidad
    
    func query() -> [Peliculas] {
        var pelicula = [Peliculas]()
        
        //Recupera AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return pelicula }
        
        //Recuperar el contexto
        let managerContext = appDelegate.persistentContainer.viewContext
        
        //Se construye el fetchRequest
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Peliculas")
        
        //Se envia la consulta al ManagerContext
        do {
            let response = try managerContext.fetch(fetchRequest)
            
            for mov in response {
                let peli = mov as! Peliculas
                pelicula.append(peli)
            }
            
        } catch let error as NSError {
            print("Could not open \(error), \(error.userInfo) ")
        }
        
        return pelicula
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell

        // Configure the cell...
        
        cell.titleMovieValue.text = movies[indexPath.row].title
        cell.genreMovieValue.text = movies[indexPath.row].genre
        cell.anioMovieValue.text = movies[indexPath.row].anio
        if let url = movies[indexPath.row].url {
          cell.imageMovie.dowloadFromServer(link: url)
        }
        cell.setFavorite(favorite: movies[indexPath.row].favorite)
        cell.delegate = self
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateFavorite(title: String, favorite: Bool) {
        
        //Recuperar AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Recuperar contexto
        let managerContext = appDelegate.persistentContainer.viewContext
        
        //Recupera la informacion
        let fetchResult: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Peliculas")
        fetchResult.predicate = NSPredicate(format: "title = %@", title)
        
        //Convierte el objeto a un NSManagedObject
        do {
            let result = try managerContext.fetch(fetchResult)
            
            for item in  result as! [NSManagedObject] {
                item.setValue(favorite, forKey: "favorite")
                
                do {
                    try managerContext.save()
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo) ")
                }
            }
            
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo) ")
        }
        
    }

}

extension ShowMovieTableViewController: MoviesTableViewCellDelegate {
    func selectFavorite(favorite: Bool, tag: Int) {
        print("Movie: \(movies[tag].title)")
        self.updateFavorite(title: movies[tag].title ?? "", favorite: favorite)
    }
}
