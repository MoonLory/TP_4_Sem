//
//  ViewController.swift
//  Task_2.2
//
//  Created by Admin on 18/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import MapKit
import CoreData

extension String {
func localized(_ lang:String) ->String {

    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)

    return NSLocalizedString(self, bundle: bundle!, comment: "")
}}

class ViewController: UIViewController, MKMapViewDelegate, WeatherGetterDelegate, CLLocationManagerDelegate, UITableViewDataSource {
    
    //MARK: - properties


    @IBOutlet weak var weatherIconView: UIImageView!
    @IBOutlet weak var weatherCancelButton: UIButton!
    @IBOutlet weak var humidityHeaderLabel: UILabel!
    @IBOutlet weak var precipitationsHeaderLabel: UILabel!
    @IBOutlet weak var windSpeedHeaderLabel: UILabel!
    @IBOutlet weak var temperatureHeaderLabel: UILabel!
    @IBOutlet weak var weatherHeaderLabel: UILabel!
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var partiesLabel: UILabel!
    @IBOutlet weak var partiesViewButton: UIButton!
    @IBOutlet weak var partiesTableView: UITableView!
    @IBOutlet weak var partiesView: UIView!
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var mapKitView: MKMapView!
    
    let minskCoordinate = CLLocationCoordinate2D(latitude: 53.893009, longitude: 27.567444)
    var region = CLCircularRegion()
    let regionRadius = 4000.0
    var point: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var circleOverlay = MKCircle()
    var regionAnnotation = MKPointAnnotation()
    var parks: [NSManagedObject] = []
    var parksOfRegion: [NSManagedObject] = []
    var parties = NSSet()
    let languageStringCodes = ["en","ru","be"]
    
    var weather: WeatherGetter!
    var tapCoordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather = WeatherGetter(delegate: self)
        weatherButton.isEnabled = false;
        let locale = NSLocale.current.languageCode
        languageSegmentedControl.selectedSegmentIndex = languageStringCodes.firstIndex(of: locale!)!
       
   /*     addPark(name: "park Gorkogo", rusName: "парк Горького", byName: "парк Горькага", longitude: 53.903362, latitude: 27.573215)
       addPark(name: "park extreme sports", rusName: "парк экстремальных видов спорта", byName: "парк экстрэмальных відаў спорта", longitude: 53.908101, latitude: 27.618377)
        addPark(name: "botanic garden", rusName: "Ботанический сад", byName: "Батанічны сад", longitude: 53.915652, latitude: 27.613030)
        addPark(name: "park Cheluskintsev", rusName: "парк Челюскинцев", byName: "парк Чалюскінцаў", longitude: 53.922239, latitude: 27.616237)
        addPark(name: "Park Dryzhby narodov", rusName: "парк Дружбы народов", byName: "парк Дружбы народаў", longitude: 53.931203, latitude: 27.568175)
        addPark(name: "park Drozdy", rusName: "парк Дрозды", byName: "парк Дразды", longitude: 53.946001, latitude: 27.485804)
        addPark(name: "Vesnyansky park", rusName: "Веснянский парк", byName: "Вяснянскі парк", longitude: 53.937352, latitude: 27.395295)
        addPark(name: "park Ugo Chavisa", rusName: "парк имени Уго Чависа", byName: "парк імя Уго Чавіса", longitude: 53.919273, latitude: 27.426767);
         addPark(name: "park in honour of 900-years of Minsk", rusName: "парк 900-летия Минска", byName: "парк 900-годдзя Мінска", longitude: 53.848098, latitude: 27.628620)
        addPark(name: "Antonovsky park", rusName: "Антоновский парк", byName: "Антонаўскі парк", longitude: 53.887883, latitude: 27.600117)
        addPark(name: "park of history of World War II", rusName: "парк истории Великой Отечественной войны", byName: "парк Гісторыі Вялікай Айчыннай вайны", longitude: 53.920917, latitude: 27.539469)
     */
        mapKitView.delegate = self
        mapKitView.setRegion(MKCoordinateRegion(center:minskCoordinate, latitudinalMeters: 12000, longitudinalMeters: 12000), animated: false)
    }
    
    func addPark(name:String,rusName:String,byName:String,longitude:Float,latitude:Float){
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let entity =
                NSEntityDescription.entity(forEntityName: "Park",
                                           in: managedContext)!
              let park = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
              park.setValue(name, forKeyPath: "name")
              park.setValue(rusName, forKey: "rusName")
              park.setValue(byName,forKey: "byName")
        park.setValue(longitude,forKey: "longitude")
        park.setValue(latitude, forKey: "latitude")
        
        let entityParty =
          NSEntityDescription.entity(forEntityName: "Party",
                                     in: managedContext)!
        let party = NSManagedObject(entity: entityParty,
                                      insertInto: managedContext)
        party.setValue("Party", forKey: "descriptions")
        party.setValue("Вечеринка", forKey: "rusDescriptions")
        party.setValue("Вечарынка", forKey: "byDescriptions")
        park.mutableSetValue(forKey: "parties").add(party)
        do {
          try managedContext.save()
          parks.append(park)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Park")
      
      
      do {
        parks = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    //MARK: - map functional

    @IBAction func mapTapped(_ sender: Any) {
        let touchLocation = (sender as! UITapGestureRecognizer).location(in: mapKitView)
        tapCoordinate = mapKitView.convert(touchLocation, toCoordinateFrom: mapKitView)
        weatherButton.isEnabled = true
        updateRegion(coordinate: tapCoordinate)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    func updateRegion(coordinate: CLLocationCoordinate2D){
        
            region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), radius: regionRadius, identifier: "SelectedArea")
            
        if (mapKitView.annotations.count>0){
            mapKitView.removeAnnotation(regionAnnotation)
        }

        regionAnnotation = MKPointAnnotation()
        regionAnnotation.coordinate = coordinate;
        let code = languageSegmentedControl.selectedSegmentIndex
        regionAnnotation.title = "Your area:".localized(languageStringCodes[code])
        mapKitView.addAnnotation(regionAnnotation)
        
        if circleOverlay.radius != 0{
            mapKitView.removeOverlay(circleOverlay)
        }
            
            circleOverlay = MKCircle(center: coordinate, radius: regionRadius)
            mapKitView.addOverlay(circleOverlay)
        updateParkData()
        table.reloadData()
    }
    
    
    //MARK: - table functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.tag == 0){
            return parksOfRegion.count
        }
        else{
            return parties.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let code = languageSegmentedControl.selectedSegmentIndex
        if(tableView.tag == 0){
            let act = tableView.dequeueReusableCell(withIdentifier: "Act", for: indexPath) as! Act

            let park = parksOfRegion[indexPath.item]
            act.parties = park.value(forKey: "parties") as! NSSet
            act.viewController = self
            act.nameLabel.text = park.value(forKey: "name".localized(languageStringCodes[code])) as? String
            act.button.setTitle("show".localized(languageStringCodes[code]), for: .normal)
            return act
        }
        else
        {
            let party = parties.allObjects[indexPath.item] as! NSManagedObject
            let act = tableView.dequeueReusableCell(withIdentifier: "Act", for: indexPath)
            act.textLabel?.text = party.value(forKey: "descriptions".localized(languageStringCodes[code])) as? String
             return act
        }
       
    }
    
    //MARK: - localization
    
    @IBAction func languageSegmentedControlTapped(_ sender: Any) {
        let code = languageSegmentedControl.selectedSegmentIndex
        var language = ""
        var flag = false
        if(mapKitView.annotations.count != 0){
            mapKitView.removeAnnotation(regionAnnotation)
            flag = true
        }
        
        weatherHeaderLabel.text = "Weather".localized(languageStringCodes[code])
        temperatureHeaderLabel.text = "Temp".localized(languageStringCodes[code])
        windSpeedHeaderLabel.text = "Wind".localized(languageStringCodes[code])
        precipitationsHeaderLabel.text = "Precipit".localized(languageStringCodes[code])
        humidityHeaderLabel.text = "Humid".localized(languageStringCodes[code])
        
        partiesLabel.text = "Part:".localized(languageStringCodes[code])
        language = "en_US".localized(languageStringCodes[code])
        if(flag){
            regionAnnotation.title = "Your local:".localized(languageStringCodes[code])
            mapKitView.addAnnotation(regionAnnotation)
        }
        
        if(!weatherView.isHidden){
            weather.getWeatherByPoint(latitude: Float(tapCoordinate.latitude), longitude: Float(tapCoordinate.longitude), language: language)
        }
        if flag{
            table.reloadData()
            partiesTableView.reloadData()
        }
    }
    
    //MARK: - update data
    
    func updateParkData(){
        parksOfRegion = []
        for parkObject in parks{
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(parkObject.value(forKey: "longitude") as! Float), CLLocationDegrees(parkObject.value(forKey: "latitude") as! Float))
            if region.contains(coordinate){
                parksOfRegion.append(parkObject)
            }
        }
    }
    
    @IBAction func partiesButtonTapped(_ sender: Any) {
        partiesView.isHidden = true
    }
    
    
    //MARK: - weather functional
    
    func didGetWeather(weather: Weather) {
        let code = languageSegmentedControl.selectedSegmentIndex
      DispatchQueue.main.async() {
        self.humidityLabel.text = "\(weather.humidity) %"
        self.windSpeedLabel.text = "\(weather.windSpeed) \("m/s".localized(self.languageStringCodes[code]))"
        self.temperatureLabel.text = "\(weather.temperature) C"
        let weatherConditions = ["no precip","rain","snow","rain and snow"]
        self.precipitationLabel.text = weatherConditions[weather.weatherID as! Int].localized(self.languageStringCodes[code])

        
        let iconStr = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weather.icon).svg")!
        self.getData(from: iconStr) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? iconStr.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.weatherIconView.image = UIImage(data: data)
            }
        }
      }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func didNotGetWeather(error: NSError) {
      DispatchQueue.main.async {
        self.showSimpleAlert(title: "Can't get the info",
                            message: "err.")
      }
      print("didNotGetWeather error: \(error)")
    }
    
    func showSimpleAlert(title: String, message: String) {
      let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
      )
      let okAction = UIAlertAction(
        title: "OK",
        style:  .default,
        handler: nil
      )
      alert.addAction(okAction)
      present(
        alert,
        animated: true,
        completion: nil
      )
    }
    
    @IBAction func weatherButtonTapped(_ sender: Any) {
        let code = languageSegmentedControl.selectedSegmentIndex
        let language = "en_US".localized(languageStringCodes[code])

        weather.getWeatherByPoint(latitude: Float(tapCoordinate.latitude), longitude: Float(tapCoordinate.longitude), language: language)
        weatherView.isHidden = false;
    }
    
    @IBAction func weatherCancelButtonTapped(_ sender: Any) {
        weatherView.isHidden = true;
    }
}

