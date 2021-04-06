//
//  Weather.swift
//  Plamen_Weather
//
//  Created by Plamen Velkov on 2021-04-05.
//

import Foundation

struct Weather : Codable{
    var tempC : Double          // {current} -> temp_c
    var feelsLikeC : Double     // {current} -> feelslike_c
    var windKph : Double        // {current} -> wind_kph
    var windDir : String        // {current} -> wind_dir
    var uv : Double             // {current} -> uv
    var precipMm : Double       // {current} -> precip_mm
    var gustKph : Double        // {current} -> gust_kph
    var humidity : Int          // {current} -> humidity
    
    init(){
        self.tempC = 0.0
        self.feelsLikeC = 0.0
        self.windKph = 0.0
        self.windDir = ""
        self.uv = 0.0
        self.precipMm = 0.0
        self.gustKph = 0.0
        self.humidity = 0
    }
    
    enum CodingKeys : String, CodingKey{
        case current = "current"
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        let currentContainer = try response.decodeIfPresent(Current.self, forKey: .current)
        self.tempC = currentContainer?.tempC ?? 0.0
        self.feelsLikeC = currentContainer?.feelsLikeC ?? 0.0
        self.windKph = currentContainer?.windKph ?? 0.0
        self.windDir = currentContainer?.windDir ?? "Unavailable"
        self.uv = currentContainer?.uv ?? 0.0
        self.precipMm = currentContainer?.precipMm ?? 0.0
        self.gustKph = currentContainer?.gustKph ?? 0.0
        self.humidity = currentContainer?.humidity ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        //do nothing
    }
}

struct Current : Codable{

    let tempC : Double          // {current} -> temp_c
    let feelsLikeC : Double     // {current} -> feelslike_c
    let windKph : Double        // {current} -> wind_kph
    let windDir : String        // {current} -> wind_dir
    let uv : Double             // {current} -> uv
    let precipMm : Double       // {current} -> precip_mm
    let gustKph : Double        // {current} -> gust_kph
    let humidity : Int          // {current} -> humidity
        
    enum CodingKeys : String, CodingKey{
        case tempC = "temp_c"
        case feelsLikeC = "feelslike_c"
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case uv = "uv"
        case precipMm = "precip_mm"
        case gustKph = "gust_kph"
        case humidity = "humidity"
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.tempC = try response.decodeIfPresent(Double.self, forKey: .tempC) ?? 0.0
        self.feelsLikeC = try response.decodeIfPresent(Double.self, forKey: .feelsLikeC) ?? 0.0
        self.windKph = try response.decodeIfPresent(Double.self, forKey: .windKph) ?? 0.0
        self.windDir = try response.decodeIfPresent(String.self, forKey: .windDir) ?? "Unavailable"
        self.uv = try response.decodeIfPresent(Double.self, forKey: .uv) ?? 0.0
        self.precipMm = try response.decodeIfPresent(Double.self, forKey: .precipMm) ?? 0.0
        self.gustKph = try response.decodeIfPresent(Double.self, forKey: .gustKph) ?? 0.0
        self.humidity = try response.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
    }
}
