//
//  CoreDataViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/25/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class CoreDataViewController: UIViewController {
    
    
    @IBOutlet weak var segmentedOperation: UISegmentedControl!
    @IBOutlet weak var showTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segmentedOperation.selectedSegmentIndex = -1
        showTextView.isEditable = false
    }
    
    
    @IBAction func segmentedOperationValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            guard SingletonOperation.shared.insert(title: "Titulo 1", genre: "Genero 1", anio: "1969", url: "http://url1", favorite: true) else { return }
        case 1:
            SingletonOperation.shared.fetchPelicula(title: "Titulo 1") { (response, pelicula) in
                if response {
                    pelicula.anio = "1970"
                    if SingletonOperation.shared.update(pelicula: pelicula) {
                        print("Ok")
                    }
                }
            }
        case 2:
            SingletonOperation.shared.fetchPelicula(title: "") { (response, pelicula) in
                if response {
                    if SingletonOperation.shared.delete(pelicula: pelicula) {
                        print("Ok")
                    }
                }
            }
        case 3:
            SingletonOperation.shared.fetchAllPeliculas { (response, data) in
                if response {
                    for item in data {
                        let result = "Title: \(item.title ?? ""), Genre: \(item.genre ?? ""), anio: \(item.anio ?? "")"
                        self.showTextView.text = result
                    }
                } else {
                    self.showTextView.text = ""
                }
            }
          default:
            SingletonOperation.shared.deleteAllData(entity: "Peliculas") { (response) in
                if response {
                    print("Ok")
                }
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
