//
//  BodyCalculator.swift
//  Task3_lab3
//
//  Created by Admin on 18/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class BodyCalculator {
    static let AMRs = [1.2, 1.375, 1.55, 1.725]
    static let alpha = [88.362, 447.593]
    static let beta = [13.397, 9.247]
    static let gamma = [4.799, 3.098]
    static let delta = [5.677, 4.330]
    
    static func calculateDailyCalories(weight: Double?, height: Double?, age: Int?, isMan: Bool, lifestyle: Int) -> Double {
        if (weight == nil || height == nil || age == nil) {
            return Double.nan
        }
        
        let flag = isMan ? 0 : 1
        let BMR = alpha[flag] + beta[flag] * weight! + gamma[flag] * height! - delta[flag] * Double(age!)
        return AMRs[lifestyle] * BMR
    }
    
    static func calculateBodyMassIndex(weight: Double?, height: Double?) -> Double {
        if (weight == nil || height == nil) {
            return Double.nan
        }
        
        let heightInMeters = height! / 100.0
        return weight! / (heightInMeters * heightInMeters)
    }
}
