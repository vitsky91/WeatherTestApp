//
//  HoursCollectionViewController.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/12/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class HoursCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dayDescription = Double(Date().timeIntervalSince1970).dateStringFromUTC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        NetworkManger.shared.networkUpdateDispatchGroup.notify(queue: .main) {[weak self] in
            self?.collectionView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollection), name: .DaySelected, object: nil)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = UIColor.hexStringToUIColor(hex: Constants.HoursWeatherColor)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UINib.init(nibName: "HoursCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    @objc func reloadCollection(_ notification: NSNotification) {
        
        if let data = notification.userInfo?["data"] as? WeatherInfoData {
            
            dayDescription = data[WeatherInfoParameters.day.rawValue] ?? Double(Date().timeIntervalSince1970).dateStringFromUTC()
            
            collectionView.reloadData()
        }
        
    }
}


extension HoursCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}

extension HoursCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return DataManager.getAllWeatherOfDay(dayDescription)?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HoursCollectionViewCell, let data = DataManager.getAllWeatherOfDay(dayDescription)?[indexPath.row] {
            
            cell.config(data: data)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}
