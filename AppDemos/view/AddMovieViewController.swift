//
//  AddMovieViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/13/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit
import CoreData

class AddMovieViewController: UIViewController {
    
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldGenre: UITextField!
    @IBOutlet weak var textFieldAnio: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var isFavorite = false
    private var movie: Movies = Movies()
    private var optionsGenre = ["Accion", "Suspenso", "Terror", "Aventura"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        movie.favorite = isFavorite
        
        let pickerGenre = UIPickerView()
        pickerGenre.delegate = self
        pickerGenre.dataSource = self
        textFieldGenre.inputView = pickerGenre
    }
    
    
    @IBAction func actionFavorite(_ sender: Any) {
        isFavorite = !isFavorite
        movie.favorite = isFavorite
        if isFavorite {
            self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            
        } else {
            self.favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
    }
    
    @IBAction func actionSave(_ sender: Any) {
        self.movie.title = self.textFieldTitle.text ?? ""
        self.movie.genre = self.textFieldGenre.text ?? ""
        self.movie.anio = self.textFieldAnio.text ?? ""
        self.movie.url = "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/12/11/naturo-monkey-selfie.jpg?w968h681"
        
        save(movie: movie)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func save(movie: Movies) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Recuperar el contexto
        let managerContext = appDelegate.persistentContainer.viewContext
        
        //Indicar cual es la entity a utilizas
        if let movieEntity = NSEntityDescription.entity(forEntityName: "Peliculas", in: managerContext) {
        
           //Recuperar el objeto para insertar
           let movies = NSManagedObject(entity: movieEntity, insertInto: managerContext)
           //Fijar valores
            movies.setValue(movie.title, forKey: "title")
            movies.setValue(movie.genre, forKey: "genre")
            movies.setValue(movie.anio, forKey: "anio")
            movies.setValue(movie.url, forKey: "url")
            movies.setValue(movie.favorite, forKey: "favorite")
            
            //Realiza la operacion
            do {
                try managerContext.save()
            } catch let error as NSError {
                print ("Could not save \(error), \(error.userInfo.description)")
            }
        
        }
    }

}

extension AddMovieViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionsGenre.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return optionsGenre[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textFieldGenre.text = optionsGenre[row]
    }
    
}
