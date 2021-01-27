
import UIKit



class ViewController: UIViewController {

    var arrayOfSavedCities: [CurrentWeatherJson] = []
    var networkManager = NetworkManegerForCurrentWeather()

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var currentWeatherCollectionVC: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        searchbar.delegate = self
 
        currentWeatherCollectionVC.dataSource = self
        currentWeatherCollectionVC.delegate = self

    }
}
//MARK: - currentWeatherCollectionView
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCurrentWeatherVC", for: indexPath) as! CellCurrentWeatherVC

        let name = self.arrayOfSavedCities[indexPath.item].main!.cityname!

        cell.labelCurrentWeatherCityName.text = name
        cell.labelCurrentWeatherCityTemperature.text = String(self.arrayOfSavedCities[indexPath.item].main!.temp!)

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.arrayOfSavedCities.count
    }
}
//MARK: - searchBar
extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        print(searchBar.text)
        searchBar.endEditing(true)

        guard let searchingCityName = searchBar.text else { return }

        let url = networkManager.createURLRequest(searchingCityName)
        networkManager.getWeather(url, searchingCityName, compelition: self.addWeatherToArrayForCell)
    }

    func addWeatherToArrayForCell(weather: CurrentWeatherJson) -> Void {
        DispatchQueue.main.async {
            print(weather.main?.temp)
            self.arrayOfSavedCities.append(weather)
            self.currentWeatherCollectionVC.reloadData()
        }
    }
}
//MARK: - NextScreenForcast
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ForcastWeatherVC") as! ForcastWeatherVC
        
        vc.currentWeatherJson = arrayOfSavedCities[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
