//
//  NetworkManager.swift
//  MyForcast
//
//  Created by 1 on 25.01.2021.
//

import Foundation

class CurrentWeatherJson: Codable {
    var main: MainCurrentWeatherJson?
}

class NetworkManeger {
    
    func createURLRequest(_ cityName: String) -> URLRequest {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: "e7fc58f1126ed00b67195097153e0987")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        print(request)
        return request
    }
    
    func getWeather(_ url: URLRequest, _ cityName: String, compelition: @escaping (CurrentWeatherJson) -> Void) {
        
        let task = URLSession(configuration: .default)
        let dataTask = task.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return print("error gamno") }
            
            let decoder = JSONDecoder()
            
            guard data != nil else { return print("void in data")}
            
            do {

                let decoderedDataCurrentWeather: CurrentWeatherJson
                decoderedDataCurrentWeather = try decoder.decode(CurrentWeatherJson.self, from: data!)
                decoderedDataCurrentWeather.main?.cityname = cityName
                //
                //                func addWeatherToArray(weather: CurrentWeatherJson) -> Void {
                //                    DispatchQueue.main.async {
                //                        print(weather)
                //                        self.arrayOfSavedCities.append(weather)
                //                        self.currentWeatherCollectionVC.reloadData()
                //                    }
                //                }
                //
                compelition(decoderedDataCurrentWeather) // addWeatherToArray(decoderedDataCurrentWeather)
            } catch {
                print(error)
            }
        }.resume()
        
    }
}






//------------------------------------------------------------------------
//class NetworkManager {
//
//    private init() {}
//
//    static let shared: NetworkManager = NetworkManager()
//
//    func getweather(city: Citymodel) -> Double? {
//
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Kyiv&units=metric&appid=e7fc58f1126ed00b67195097153e0987"
//        let url = URL(string: urlString)
//
//        guard url != nil else { return 2.0 }
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//
//            if error == nil && data != nil {
//
//                let decoder = JSONDecoder()
//
//                do {
//                    let kyivCurrentWeatherMain = try decoder.decode(CurrentWeatherJson.self, from: data!)
//                    ViewController.arrayOfSavedCities[0].temperature = kyivCurrentWeatherMain.main?.temp
//                    print(kyivCurrentWeatherMain.main?.temp as Any)
//                } catch {
//                    print("ERROR in JSON parsing")
//                }
//            }
//        }.resume()
//        return ViewController.arrayOfSavedCities[0].temperature
//    }
//
//}

//                    DispatchQueue.main.async { //выполни от эта на мэйн потоке
//                        self.CurrentWeatherCollectionVC.reloadData()
//                    }
