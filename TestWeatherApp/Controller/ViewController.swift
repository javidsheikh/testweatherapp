//
//  ViewController.swift
//  TestWeatherApp
//
//  Created by Javid Sheikh on 13/01/2018.
//  Copyright © 2018 Javid Sheikh. All rights reserved.
//

import UIKit
import Marshal
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, WeatherHeaderDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var weather = [ThreeHourForecast]()
    var locationManager: CLLocationManager!
    lazy var geocoder = CLGeocoder()
    lazy var currentLocation = "Not found"
    lazy var displyedWeatherLocation = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let headerNib = UINib(nibName: "WeatherHeaderTableViewCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "headerCell")
        let nib = UINib(nibName: "WeatherDisplayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "weatherCell")
        
        tableView.allowsSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    // MARK: private methods
    private func initialiseWeatherModel(withJSONObject jsonObject: Dictionary<String, Any>) {
        do {
            weather = try jsonObject.value(for: "list")
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchWeatherDataFor(location: String) {
        if let encodedLocationString = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            NetworkRequestHelper.fetchWeatherJSONData(for: encodedLocationString) { jsonObject in
                self.displyedWeatherLocation = location
                self.initialiseWeatherModel(withJSONObject: jsonObject)
            }
        }
    }
    
    // MARK: weather header delegate methods
    func getForecastForNew(location: String) {
        fetchWeatherDataFor(location: location)
    }
    
    func getForecastForCurrentLocation() {
        fetchWeatherDataFor(location: currentLocation)
    }
    
    // MARK: table view delegate methods
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! WeatherHeaderTableViewCell
        headerViewCell.delegate = self
        headerViewCell.currentLocationLabel.text = currentLocation.capitalized
        headerViewCell.displayedWeatherLocationLabel.text = displyedWeatherLocation.capitalized
        return headerViewCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherDisplayTableViewCell
        let weatherSnippet = weather[indexPath.row]
        cell.timeLabel.text = weatherSnippet.displayTime
        cell.temperatureLabel.text = "\(weatherSnippet.celsiusTemperature)°C"
        cell.windSpeedLabel.text = "\(weatherSnippet.windSpeed) mph"
        if let description = weatherSnippet.weatherArray.first?.description {
            cell.descriptionLabel.text = description.capitalized
        }
        if let iconCode = weatherSnippet.weatherArray.first?.icon {
            NetworkRequestHelper.fetchWeatherIcon(withCode: iconCode) { data in
                let image = UIImage(data: data)
                cell.weatherIcon.image = image
            }
        }
        return cell
    }
    
    // MARK: location manager methods
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        geocode(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func geocode(lat: Double, lon: Double) {
        let location = CLLocation(latitude: lat, longitude: lon)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first, let locality = placemark.locality {
                currentLocation = locality
                fetchWeatherDataFor(location: locality)
            }
        }
    }
}


