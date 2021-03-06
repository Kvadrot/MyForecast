
import Foundation

class CurrentWeatherJson: Codable {

    var coord: Coordinates
    var main: MainCurrentWeatherJson?
}

class NetworkManegerForCurrentWeather {

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

                compelition(decoderedDataCurrentWeather)

            } catch {
                print(error)
            }
        }.resume()
        
    }
}

