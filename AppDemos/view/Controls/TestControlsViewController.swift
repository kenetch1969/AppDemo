//
//  TestControlsViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//
//https://github.com/kenetch1969/language
//UITextField
//UITextView
//UISegmentedControl ok
//UISlider ok
//UIStepper ok
//UISwitch ok
//UIButton ok
//UIDatePicker
//UIToolbar ok
//UITabBar ok
//UIImageView
//UIActivityIndicatorView ok
//UIAlertController ok
//UIProgressView ok
//UISearchBar

//UIPageControl
//WKWebView

import UIKit

class TestControlsViewController: UIViewController {
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var sliderPorcent: UISlider!
    @IBOutlet weak var porcentValue: UILabel!
    @IBOutlet weak var stepperLabelValue: UILabel!
    @IBOutlet weak var steeper: UIStepper!
    @IBOutlet weak var switchOption: UISwitch!
    @IBOutlet weak var onView: UIView!
    @IBOutlet weak var startLabelValue: UILabel!
    @IBOutlet weak var simpleProgress: UIProgressView!
    @IBOutlet weak var simpleLabel: UILabel!
    var current: Int = 0
    
    private var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Fijamos opcion default
        self.segmentControl.selectedSegmentIndex = 0
        self.segmentControl.addTarget(self, action: #selector(TestControlsViewController.indexChanged(_:)), for: .valueChanged)
        self.sliderPorcent.setValue(0, animated: false)
        print("Valor : \(self.sliderPorcent.value)")
        self.steeper.value = 5
        self.switchOption.isOn = false
        self.onView.backgroundColor = .red
    }
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Otro A")
            self.showAlert(title: "Test Control", message: "Otro A")
        case 1:
            print("Otra B")
        case 2:
            print("Otra C")
        default:
            print("Otra D")
        }
        
    }
    

    @IBAction func indexChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print(sender.titleForSegment(at: 0) ?? "")
        case 1:
            print(sender.titleForSegment(at: 1) ?? "")
        case 2:
            print(sender.titleForSegment(at: 2) ?? "")
        default:
            print(sender.titleForSegment(at: 3) ?? "")
        }
        
    }
    
    //Es slider valuChanged
    @IBAction func sliderValueChanged(_ sender: UISlider){
        let value = sender.value
        self.porcentValue.text = String(format: "%.2f", value)
    }
    
    @IBAction func steeperValueChanged(_ sender: UIStepper) {
        let value = sender.value
        self.stepperLabelValue.text = String(format: "%.0f", value)
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            self.onView.backgroundColor = .green
        } else {
            self.onView.backgroundColor = .red
        }
    }
    
    @IBAction func startAction(_ sender: UIBarButtonItem) {
        number+=1
        self.startLabelValue.text = "Add: \(number)"
    }
    
    
    @IBAction func restAction(_ sender: UIBarButtonItem) {
        number-=1
        self.startLabelValue.text = "Rest: \(number)"
    }
    
    @IBAction func actionProgress(_ sender: UIButton) {
        // Get current values.
        let i = self.current
            let max = 10

           // If we still have progress to make.
           if i <= max {
               // Compute ratio of 0 to 1 for progress.
               let ratio = Float(i) / Float(max)
               // Set progress.
               simpleProgress.progress = Float(ratio)
               // Write message.
               simpleLabel.text = "Processing \(i) of \(max)..."
            self.current+=1
           }
    }
    
    @IBAction func showActivityIndicator(_ sender: UIButton) {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = UIColor.red
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            activityIndicatorView.stopAnimating()
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


