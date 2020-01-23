//
//  DaysTableViewController.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/12/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit

class DaysTableViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DaysTableViewCell.nib(), forCellReuseIdentifier: DaysTableViewCell.reuseIdentifier())
        
        NetworkManger.shared.networkUpdateDispatchGroup.notify(queue: .main) {[weak self] in
            self?.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: .DaySelected, object: nil)
    }
    
    @objc func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension DaysTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let data = DataManager.prepareData(index: indexPath.row) {
            
            let notification = ["data": data]
            NotificationCenter.default.post(name: .DaySelected, object: nil, userInfo: notification)
        }
    }
    
}

// MARK: - UITableViewDataSource
extension DaysTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5 //We have only 5 days prediction from API
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.reuseIdentifier(), for: indexPath) as? DaysTableViewCell {
            
            if let data = DataManager.prepareData(index: indexPath.row, options: [.max,.min,.day,.icon]) {
                
                cell.config(data: data)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}
