//
//  MainViewController.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/12/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var stack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - Transition handler
extension MainViewController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isPortrait {
            
            stack.axis = .vertical
        } else {
            
            stack.axis = .horizontal
        }
    }
}
