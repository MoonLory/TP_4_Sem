//
//  WeatherGetterDelegate.swift
//  Task_2.2
//
//  Created by Admin on 18/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol WeatherGetterDelegate {
  func didGetWeather(weather: Weather)
  func didNotGetWeather(error: NSError)
}
 
 
// MARK: WeatherGetter
// ===================
 
class WeatherGetter {
  
  private let yandexWeatherAPIBaseURL = "https://api.weather.yandex.ru/v1/forecast"
  private let yandexAPIKey = "058e1a8e-caac-43c7-a2a0-90380aa902b8"
 
  private var delegate: WeatherGetterDelegate
  
  
  // MARK: -
  
  init(delegate: WeatherGetterDelegate) {
    self.delegate = delegate
  }
  
    func getWeatherByPoint(latitude: Float, longitude:Float,language:String) {
        let weatherRequestURL = URL(string: "\(yandexWeatherAPIBaseURL)?lat=\(latitude)&lon=\(longitude)&lang=\(language)&extra=true")!
    getWeather(weatherRequestURL: weatherRequestURL)
  }
  
  func getWeather(weatherRequestURL: URL) {
    
    // This is a pretty simple networking task, so the shared session will do.
    let session = URLSession.shared
    var request = URLRequest(url: weatherRequestURL)
    request.addValue(yandexAPIKey, forHTTPHeaderField: "X-Yandex-API-Key")
    // The data task retrieves the data.
    let dataTask = session.dataTask(with: request) {
        (data: Data?, response: URLResponse?, error: Error?) in
      if let networkError = error {
        self.delegate.didNotGetWeather(error: networkError as NSError)
      }
      else {
        do {
          // Try to convert that data into a Swift dictionary
            let weatherData = try JSONSerialization.jsonObject(
                with: data!,
                options: .mutableContainers) as! [String: AnyObject]
 
          let weather = Weather(weatherData: weatherData)
          
            self.delegate.didGetWeather(weather: weather)
        }
        catch let jsonError as NSError {
          // An error occurred while trying to convert the data into a Swift dictionary.
            self.delegate.didNotGetWeather(error: jsonError)
        }
      }
        }

    dataTask.resume()
  }
  
}
