//
//  JsonTest.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/17/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

struct Human: Codable {
    let first: String
    let last: String
    let user_age: Int
}

struct Propiedad: Codable {
    let casa: Casa
    let muebles: Muebles
    let cochera: Cochera
}

struct Casa: Codable {
    let calle: String
    let postal: Int
    let pais: String
}

struct Muebles: Codable {
    let colchon: String
    let cocina: String
    let sala: String
}

struct Cochera: Codable {
    let puerta: String
    let herramienta: String
}

enum Style: String, Codable {
    case rowHouse
    case apartment = "apartment"
    case house
}

struct Home: Codable {
    let people: [Person]
    let room: Room
    let car: Bool?
    let buildDate: Date
    let time: Time
    let style: Style
    let url: URL

    enum CodingKeys: String, CodingKey {
        case people = "family"
        case room
        case car
        case buildDate = "build_date"
        case time
        case style = "home_style"
        case url = "home_url"
    }
}

struct Person: Codable {
    let name: String
    let address: String
}

struct Time: Codable {
    let hour: Hour
}

struct Hour: Codable {
    let minute: Int
}

struct Room: Codable {
    let direction: Int
    let name: String
    let wall: Wall

    enum CodingKeys: String, CodingKey {
        case direction = "room_direction"
        case name
        case wall
    }
}

struct Wall: Codable {
    let color: Int
    let width: Int
}


class JsonTest {
    
    func parseSimpleJson() {
        let humanDictionary = """
                                {"first": "Tom", "last": "Smith", "user_age": 31}
                             """
        let decodedDictionary = try! JSONDecoder().decode(Human.self, from: humanDictionary.data(using: .utf8)!)
        print("Human: \(decodedDictionary.first), \(decodedDictionary.last)")
    }
    
    func parseSimpleArrayjson() {
        let humanDictionary = """
                                [{"first": "Tom", "last": "Smith", "user_age": 31},
                                {"first": "George", "last": "Smith", "user_age": 31},
                                {"first": "Bellin", "last": "Smith", "user_age": 31},
                                ]
                             """
        let decodedDictionary = try! JSONDecoder().decode([Human].self, from: humanDictionary.data(using: .utf8)!)
        
        for item in decodedDictionary {
            print("Human: \(item.first), \(item.last)")
        }
        
    }
    
    func parseSimpleDictionary() {
        let jsonDictionary = """
            {"tom": {"first": "Tom", "last": "Smith", "user_age": 31},
            "bob": {"first": "George", "last": "Jhonson", "user_age": 31},
            "peter": {"first": "Bellin", "last": "Bernulli", "user_age": 31}}
        """
        let decodedDictionary = try! JSONDecoder().decode([String: Human].self, from: jsonDictionary.data(using: .utf8)!)
        
        print(decodedDictionary["tom"]?.last ?? "")
        print(decodedDictionary["bob"]?.last ?? "")
        print(decodedDictionary["peter"]?.last ?? "")
        
    }
    
    func parseDictionaryJson() {
        let dictionaryThings = """
                                {
                                 "casa": {"calle": "street 1", "postal": 55555, "pais": "Mexico"},
                                 "muebles": {"colchon": "Si", "cocina": "Si", "sala": "Si"},
                                 "cochera": {"puerta": "Si", "herramienta": "Si"},
                                }
                             """
        let decodedDictionary = try! JSONDecoder().decode(Propiedad.self, from: dictionaryThings.data(using: .utf8)!)
        
        print(decodedDictionary.casa.calle)

    }
    
    func parseHome() {

        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601

        let home = Home(people: [Person(name: "aaa", address: "bbb"), Person(name: "aaa1", address: "bbb1")], room: Room(direction: 2, name: "Living Room", wall: Wall(color: 10, width: 20)), car: true, buildDate: Date(), time: Time(hour: Hour(minute: 100)), style: .apartment, url: URL(string: "http://www.google.com")!)

        if let encodedHomeObject = try? JSONEncoder().encode(home) {
            print(String(data: encodedHomeObject,encoding: .utf8)!)

            if let decodedHomeObject = try? JSONDecoder().decode(Home.self, from: encodedHomeObject) {
                print(decodedHomeObject)
            }
        } else {
            print("asds")
        }

        let homeJSON = """
        {"family": [{"name": "aaa", "address": "bbb"}, {"name": "aaa1", "address": "bbb1"}], "room": {"room_direction": 2, "name": "Living Room", "wall": {"color": 10, "width": 20}}, "build_date": "10/29/2017", "time": {"hour": {"minute": 900 }}, "home_style": "apartment", "home_url": "htwww.google.com"}
        """

        if let decodedHomeObject = try? jsonDecoder.decode(Home.self, from: homeJSON.data(using: .utf8)!) {
            print(decodedHomeObject)
            if let encodedHomeObject = try? jsonEncoder.encode(decodedHomeObject) {
                print(String(data: encodedHomeObject,encoding: .utf8)!)
            }
        } else {
            print("Error Occurred")
        }

        do {
            let decodedHomeObject = try jsonDecoder.decode(Home.self, from: homeJSON.data(using: .utf8)!)
            print(decodedHomeObject)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}
