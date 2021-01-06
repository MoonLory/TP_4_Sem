//
//  CityInfoRetriever.m
//  Task2_lab7
//
//  Created by Admin on 18/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CityInfoRetriever.h"

static NSDictionary<NSString *, NSNumber *> *temperatures = nil;
static NSDictionary<NSString *, NSString *> *countries = nil;

@implementation CityInfoRetriever

+ (void) initialize {
    temperatures = @{
       @"Minsk" : @3,
       @"Hrodno": @5,
       @"Moscow": @6,
       @"Sochi": @17,
    };
    
    countries = @{
        @"Minsk" : @"2 018 000",
        @"Hrodno": @"373 000",
        @"Moscow": @"14 300 000",
        @"Sochi": @"364 000"
    };
}

+ (NSNumber *) getTemperatureByCity: (NSString *)cityName {
    return (NSNumber *)[temperatures objectForKey: cityName];
}

+ (UIColor *) getColorByTemperature: (NSNumber *)temperature {
    if (temperature.intValue < 10)
        return UIColor.blueColor;
    else if (temperature.intValue < 20)
        return UIColor.greenColor;
    else
        return UIColor.orangeColor;
}

+ (NSString *) getCountryByCity: (NSString *) cityName {
    return (NSString *)[countries objectForKey: cityName];
}

+ (UIImage *) getMayorByCity: (NSString *) cityName {
    return [UIImage imageNamed: [cityName stringByAppendingString: @" Mayor"]];
}



@end
