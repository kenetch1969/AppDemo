//
//  CarViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/13/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ferrari = Car(type: .Sport, transmissionMode: .Drive)
        ferrari.start(minutos: 120)
        
        print(ferrari.miles) // => 140
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
