//
//  WeatherFetcher.swift
//  Plamen_Weather
//
//  Created by Plamen Velkov on 2021-04-05.
//

import Foundation

class WeatherFetcher : ObservableObject{
    var cityVC : String = "London"
    
    
    @Published var weatherDetails = Weather()
    
    private static var shared : WeatherFetcher?
    
    static func getInstance() -> WeatherFetcher{
        if shared != nil{
            return shared!
        }else{
            return WeatherFetcher()
        }
    }
    
    func fetchDataFromAPI(city : String){
        var apiURL = "https://api.weatherapi.com/v1/current.json?key=a1b20ff06ed74c60a08143803210404&q=\(city)&aqi=no"
        guard let api = URL(string: apiURL) else{
            return
        }
        
        URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error{
                print(#function, "Couldn't fetch data",err)
            }else{
                //received data or response
                DispatchQueue.global().async {
                    do{
                        if let jsonData = data{
                            let decoder = JSONDecoder()
                            let decodedList = try decoder.decode(Weather.self, from: jsonData)
                            
                            DispatchQueue.main.async {
                                self.weatherDetails = decodedList
                            }
                        }else{
                            print(#function, "No JSON data received")
                        }
                    }catch let error{
                        print(#function, error)
                    }
                }
            }
        }.resume()
    }
}
