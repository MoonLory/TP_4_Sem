//
//  Weather.swift
//  Task_2.2
//
//  Created by Admin on 18/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct Weather {
  
    let temperature:Int
    let icon:String
    let windSpeed: NSNumber
    let weatherID: NSNumber
    let humidity:NSNumber

  
  init(weatherData: [String: AnyObject]) {
    let factData = weatherData["fact"] as! [String: AnyObject]
    temperature = factData["temp"] as! Int
    icon = factData["icon"] as! String
    windSpeed = factData["wind"] as! NSNumber
    weatherID = factData["prec_type"] as! NSNumber
    humidity = factData["humid"] as! NSNumber
  }
  
}
