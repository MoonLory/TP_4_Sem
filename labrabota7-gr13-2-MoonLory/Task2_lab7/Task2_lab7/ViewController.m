//
//  ViewController.m
//  Task2_lab7
//
//  Created by Admin on 18/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "ViewController.h"
#import "CityInfoRetriever.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIButton *temperatureButton;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UIImageView *coatOfArmsView;
@property (weak, nonatomic) IBOutlet UIImageView *flagView;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@end

@implementation ViewController
- (IBAction) temperatureButtonTouched: (id) sender {
    @try {
        NSNumber *temp = [CityInfoRetriever getTemperatureByCity: self.cityTextField.text];
        [self.temperatureLabel setText: [temp.description stringByAppendingString: @" C"]];
        [self.temperatureLabel setTextColor: [CityInfoRetriever getColorByTemperature: temp]];
    
        [self.countryLabel setText: [@"Population " stringByAppendingString: [CityInfoRetriever getCountryByCity:   self.cityTextField.text]]];
    
        [self.flagView setImage: [CityInfoRetriever getMayorByCity: self.cityTextField.text]];
    }
    @catch (NSException *ex) {
        [self.temperatureLabel setText: @""];
        [self.countryLabel setText: @""];
        [self.flagView setImage: nil];
    }
}

- (void)viewDidLoad {
  [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

