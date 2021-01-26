//
//  ViewController.swift
//  MyForcast
//
//  Created by 1 on 25.01.2021.
//

import UIKit



class ViewController: UIViewController {
    
//    var kyiv = Citymodel(name: "Kyiv", temperature: -20)
//    var dnepr = Citymodel(name: "Dnepr", temperature: -20)
//
    var arrayOfSavedCities: [CurrentWeatherJson] = []
    var networkManager = NetworkManeger()

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var currentWeatherCollectionVC: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbar.delegate = self
 
        currentWeatherCollectionVC.dataSource = self
        currentWeatherCollectionVC.delegate = self
        
        
    }
}

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
