//
//  ForecastViewController.swift
//  DiscomfortIndexApp
//
//  Created by Tatsuya Amida on 2020/05/03.
//  Copyright © 2020 T.A. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var firstDayLabel: UILabel!
    @IBOutlet weak var firstMaxTemperatureLabel: UILabel!
    @IBOutlet weak var firstMinTemperatureLabel: UILabel!
    @IBOutlet weak var firstConditionImageView: UIImageView!
    @IBOutlet weak var firstDiscomfortIndexImageView: UIImageView!
    @IBOutlet weak var secondDayLabel: UILabel!
    @IBOutlet weak var secondMaxTemperatureLabel: UILabel!
    @IBOutlet weak var secondMinTemperatureLabel: UILabel!
    @IBOutlet weak var secondConditionImageView: UIImageView!
    @IBOutlet weak var secondDiscomfortIndexImageView: UIImageView!
    
    var forecastManager = ForecastManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastManager.delegate = self
        searchTextField.delegate = self
    }
    
}

extension ForecastViewController: UITextFieldDelegate {
    
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
            forecastManager.fetchForecast(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

extension ForecastViewController: ForecastManagerDelegate {
       
       func didUpdateForecast(weatherManager: ForecastManager, firstWeather: WeatherModel, secondWeather: WeatherModel) {
           DispatchQueue.main.async {
               self.cityLabel.text = firstWeather.cityName
               self.firstDayLabel.text = firstWeather.formattedDate
               self.firstMaxTemperatureLabel.text = String(firstWeather.maxTemperature)
               self.firstMinTemperatureLabel.text = String(firstWeather.minTemperature)
               self.firstConditionImageView.image = UIImage(systemName: firstWeather.conditionName)
               self.firstDiscomfortIndexImageView.image = UIImage(named: firstWeather.discomfortIndexName)
               self.secondDayLabel.text = secondWeather.formattedDate
               self.secondMaxTemperatureLabel.text = String(secondWeather.maxTemperature)
               self.secondMinTemperatureLabel.text = String(secondWeather.minTemperature)
               self.secondConditionImageView.image = UIImage(systemName: secondWeather.conditionName)
               self.secondDiscomfortIndexImageView.image = UIImage(named: secondWeather.discomfortIndexName)
           }
       }
       
       func didFailWithError(error: Error) {
           print(error)
       }
}
