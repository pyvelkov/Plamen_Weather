//
//  ViewController.swift
//  Plamen_Weather
//
//  Created by Plamen Velkov on 2021-03-31.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet var pkrCity : UIPickerView!
    @IBOutlet var lblTempC : UILabel!
    @IBOutlet var lblFeelsLike : UILabel!
    @IBOutlet var lblWinKph : UILabel!
    @IBOutlet var lblWindDir : UILabel!
    @IBOutlet var lblUV : UILabel!
    @IBOutlet var lblPrecipitation : UILabel!
    @IBOutlet var lblWindGust : UILabel!
    @IBOutlet var lblHumidity : UILabel!
    
    let cityList = ["Toronto", "London", "Paris", "Berlin", "Moscow", "Beijing", "Mumbai", "Varadero", "Dubai", "Rome"]
    private var weatherDetails : Weather = Weather()
    private var cancellables : Set<AnyCancellable> = []
    private let weatherFetcher = WeatherFetcher.getInstance()
    
    var citySelected = "Toronto"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.weatherFetcher.fetchDataFromAPI(city: self.citySelected)
        self.receiveChanges()
        
        self.pkrCity.dataSource = self
        self.pkrCity.delegate = self
    }

    func setWeatherData(){
        self.lblTempC.text = "\(self.weatherDetails.tempC)"
        self.lblFeelsLike.text = "\(self.weatherDetails.feelsLikeC)"
        self.lblWinKph.text = "\(self.weatherDetails.windKph)"
        self.lblWindDir.text = "\(self.weatherDetails.windDir)"
        self.lblUV.text = "\(self.weatherDetails.uv)"
        self.lblPrecipitation.text = "\(self.weatherDetails.precipMm)"
        self.lblWindGust.text = "\(self.weatherDetails.gustKph)"
        self.lblHumidity.text = "\(self.weatherDetails.humidity)"
    }
    
    private func receiveChanges(){
        self.weatherFetcher.$weatherDetails.receive(on: RunLoop.main)
            .sink{ (weather) in
                print(#function, "Received Weather : ", weather)
                self.weatherDetails = weather
                self.setWeatherData()
            }
            .store(in : &cancellables)
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cityList[row]
    }
    
    //this is the main function that will be doing all the heavy lifting of getting data and updating it
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function, "Selected City : \(self.cityList[row])")
        self.citySelected = self.cityList[row]
        self.weatherFetcher.fetchDataFromAPI(city: self.citySelected)
        self.setWeatherData()
    }
    
    
}

