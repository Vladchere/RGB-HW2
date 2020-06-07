//
//  mainViewController.swift
//  RGB HW2
//
//  Created by Vladislav on 07.06.2020.
//  Copyright © 2020 Vladislav Cheremisov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var mainView: UIView!

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setupVC = segue.destination as? SetupViewController else { return }
        
        setupVC.colorFromMainView = mainView.backgroundColor
        setupVC.delegate = self
    }
}

// MARK: - Extension
extension MainViewController: SetupViewControllerDelegate {
    func setColorMainView(_ color: UIColor) {
        mainView.backgroundColor = color
    }
}
