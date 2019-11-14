//
//  Movies.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/13/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation


class Movies {
    var title:String
    var genre: String
    var anio: String
    var url: String
    var favorite: Bool = false
    
        
    init(title: String, genre: String, anio: String, url: String) {
        self.title = title
        self.genre = genre
        self.anio = anio
        self.url = url
        
    }
    
    convenience init() {
        self.init(title: "Titulo 1", genre: "Genero 1", anio: "2019", url: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/12/11/naturo-monkey-selfie.jpg?w968h681")
    }
    
}
