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
//    static var arrayOfSavedCities: [Citymodel] = []
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var currentWeatherCollectionVC: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbar.delegate = self
 
//        currentWeatherCollectionVC.dataSource = self
//        currentWeatherCollectionVC.delegate = self
        
        
    }
}

//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCurrentWeatherVC", for: indexPath) as! CellCurrentWeatherVC
//
//        let name = ViewController.arrayOfSavedCities[indexPath.item].cityName
//
//
//        //ViewController.arrayOfSavedCities[indexPath.item].temperature
//
//        cell.labelCurrentWeatherCityName.text = name
//        cell.labelCurrentWeatherCityTemperature.text = String(NetworkManager.shared.getweather(city: kyiv)!)
//        return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return ViewController.arrayOfSavedCities.count
//    }
//}

extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        print(searchBar.text)
        searchBar.endEditing(true)

        guard let searchingCityName = searchBar.text else { return }

        NetworkManeger.init(searchingCityName)
    }
}
