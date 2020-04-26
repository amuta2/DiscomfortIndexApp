//
//  ViewController.swift
//  DiscomfortIndexApp
//
//  Created by Tatsuya Amida on 2020/04/13.
//  Copyright © 2020 T.A. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)

        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.cityName)
        print(weather.conditionName)
        print(weather.tempreture)
        print(weather.humidity)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

