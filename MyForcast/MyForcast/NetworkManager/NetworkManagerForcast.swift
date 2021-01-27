
import Foundation

class ForcastWeatherJson: Codable {

    var daily: [MainForcast]?
    var cityName: String?
}

class NetworkManagerForcast {
    
    func createURLForcastRequest(_ lat: Double , _ lon: Double ) -> URLRequest {

        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/onecall"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: "e7fc58f1126ed00b67195097153e0987")]

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"

        return request
    }
    
    func getForcast(_ url: URLRequest, _ cityName: String, compelition: @escaping (ForcastWeatherJson) -> Void) {
        
        let task = URLSession(configuration: .default)
        let dataTask = task.dataTask(with: url) { (data, response, error) in

            guard error == nil else { return print("error gamno") }

            let decoder = JSONDecoder()

            guard data != nil else { return print("void in data")}

            do {

                let decoderedDataForcastWeather: ForcastWeatherJson
                decoderedDataForcastWeather = try decoder.decode(ForcastWeatherJson.self, from: data!)
                decoderedDataForcastWeather.cityName = cityName

                compelition(decoderedDataForcastWeather)
            } catch {
                print(error)
            }
        }.resume()
        
    }
}
