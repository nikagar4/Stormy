//
//  ViewController.swift
//  Stormy
//
//  Created by Nikoloz Garibashvili on 3/8/16.
//  Copyright © 2016 Tegeta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    
    
    private let forecastAPIKey = "yourAPIKey"
    //let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
    let coordinate: (lat: Double, long: Double) = (41.706799,44.780346)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveWeatherFocerast()
    }
    
    func retrieveWeatherFocerast(){
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long){
            (let currently) in
            if let currentWeather = currently {
                // Update UI
                dispatch_async(dispatch_get_main_queue()){
                    
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = summary
                    }
                    
                    self.toggleRefreshAnimation(false)
                }
            }
        }
    }
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherFocerast()
    }
    func toggleRefreshAnimation(on: Bool){
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else{
            activityIndicator?.stopAnimating()
        }
    }
        /*
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
        let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
    
        // Data object to fetch weather data
        //let weatherData = NSData(contentsOfURL: forecastURL!)
        //print(weatherData
        
        // Use NSURLSession API to fetch data
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        // NSURLRequest object
        let request = NSURLRequest(URL: forecastURL!)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
        }
        dataTask.resume()
        */
        /*if let plistPath = NSBundle.mainBundle().pathForResource("CurrentWeather", ofType: "plist"),
        let weatherDictionary = NSDictionary(contentsOfFile: plistPath),
        let currentWeatherDictionary = weatherDictionary["currently"] as? [String:AnyObject]{
            let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
            
            currentTemperatureLabel?.text = "\(currentWeather.temperature)º"
            currentHumidityLabel?.text = "\(currentWeather.humidity)%"
            currentPrecipitationLabel?.text = "\(currentWeather.precipProbability)%"
        }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

