
import UIKit

class ForcastWeatherVC: UIViewController {

    let networkManagerForcast = NetworkManagerForcast()
    var currentWeatherJson: CurrentWeatherJson?
    var forcastsForCell: ForcastWeatherJson?

    @IBOutlet weak var forecastCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = (currentWeatherJson?.coord.lat)!
        let lon = (currentWeatherJson?.coord.lon)!
        let cityName = (currentWeatherJson?.main?.cityname)!
        let url = networkManagerForcast.createURLForcastRequest(lat, lon)
        
        networkManagerForcast.getForcast(url, cityName, compelition: self.addForcastToArrayOfForcast)

        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self

    }
}
    
extension ForcastWeatherVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return forcastsForCell?.daily?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "СellForcast", for: indexPath) as! CellForcast

        let name = self.forcastsForCell?.cityName
        let dataForcast = (self.forcastsForCell?.daily?[indexPath.item].dt)
        let temperature = self.forcastsForCell?.daily?[indexPath.item].temp?.day
        let date = Date(timeIntervalSince1970: TimeInterval(dataForcast!))
        cell.labelCityNameForcast.text = name

        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        cell.labelDataForcast.text = String((formatter1.string(from: date)))
        cell.labelTemperatureForcast.text = String(round(temperature!))

        return cell
    }
    
}

extension ForcastWeatherVC {
    func addForcastToArrayOfForcast(forcast: ForcastWeatherJson) {
        DispatchQueue.main.async {
            self.forcastsForCell = forcast
            self.forecastCollectionView.reloadData()
        }
    }
}
