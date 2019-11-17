//
//  JsonExamplesViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/17/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class JsonExamplesViewController: UIViewController {

    private let jsonTest = JsonTest()
    @IBOutlet weak var segmentedTest: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.segmentedTest.selectedSegmentIndex = -1
    }
    
    
    @IBAction func actionSegmented(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("0")
            jsonTest.parseSimpleJson()
        case 1:
            print("1")
            jsonTest.parseSimpleArrayjson()
        case 2:
            print("2")
            jsonTest.parseSimpleDictionary()
        case 3:
            print("3")
            jsonTest.parseDictionaryJson()
        case 4:
            print("4")
            jsonTest.parseHome()
        case 5:
            print("5")
        case 6:
            print("6")
        default:
            print("7")
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
