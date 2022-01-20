//
//  CarDetailViewController.swift
//  Garage
//
//  Created by adam smith on 1/19/22.
//

import UIKit

class CarDetailViewController: UIViewController {
    //MARK: - Properties
    var car: Car? = nil
    
    
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var carTypePicker: UIPickerView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let car = car else {return}
        updateUI(car: car)
    }
    
    @IBAction func clearDetailsOfCar(_ sender: UIButton) {
        makeTextField.text = ""
        modelTextField.text = ""
        yearTextField.text = ""
    }
    
    @IBAction func deleteCar(_ sender: UIButton) {
        if let car = car {
            CarController.sharedInstance.deleteCar(car: car)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveCarDetails(_ sender: UIBarButtonItem) {
        guard let model = modelTextField.text,
              !model.isEmpty,
              let make = makeTextField.text,
              !make.isEmpty,
              let yearString = yearTextField.text,
              !yearString.isEmpty,
              let year = Int(yearString)
        else {return}
        
        if let car = car {
            // updating car
            CarController.sharedInstance.updateCar(car: car, make: make, model: model, year: year, defaultImage: .none)
        } else {
            // create new car
            CarController.sharedInstance.createCar(make: make, model: model, year: year, defaultImage: .none)
            self.navigationController?.popViewController(animated: true)
        }
    }
    //MARK: - Helper Functions
    func updateUI(car: Car) {
        makeTextField.text = car.make
        modelTextField.text = car.model
        yearTextField.text = "\(car.year)"
    }
}
