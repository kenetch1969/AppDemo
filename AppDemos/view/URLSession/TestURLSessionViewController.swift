//
//  TestURLSessionViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/14/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class TestURLSessionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func actionTestGet(_ sender: Any) {
        let session = URLSession.shared
        let url = URL(string: "https://learnappmaking.com/ex/users.json")!
        
        let task = session.dataTask(with: url) { data, response, error in
        
            if error != nil || data == nil {
                print("Client error!")
                return
            }
        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Server error!")
                return
            }
        
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
        
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    
    @IBAction func actionTestPost(_ sender: Any) {
        let url = URL(string: "https://httpbin.org/post")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
    //https://jsonplaceholder.typicode.com/
    @IBAction func actionTestPostJson(_ sender: Any) {
        
        let parameter = ["username":"kilo_loco", "tweet":"HelloWorld"]
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, [200,201].contains(response.statusCode)  else {
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }

            }
        }.resume()
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
