//
//  CityInfoRetriever.h
//  Task2_lab7
//
//  Created by Admin on 18/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#ifndef WeatherInfoRetriever_h
#define WeatherInfoRetriever_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CityInfoRetriever : NSObject
+ (NSNumber *) getTemperatureByCity: (NSString *)cityName;
+ (UIColor *) getColorByTemperature: (NSNumber *)temperature;
+ (NSString *) getCountryByCity: (NSString *)cityName;
+ (UIImage *) getMayorByCity: (NSString *)cityName;
@end

#endif /* WeatherInfoRetriever_h */
