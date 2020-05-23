//
//  ViewController.swift
//  RGB HW2
//
//  Created by Vladislav on 22.05.2020.
//  Copyright © 2020 Vladislav Cheremisov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var rgbView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sliders
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        redSlider.value = 0
        greenSlider.value = 0.5
        blueSlider.value = 1
        
        // Labels
        redLabel.text = sliderValueToString(for: redSlider)
        greenLabel.text = sliderValueToString(for: greenSlider)
        blueLabel.text = sliderValueToString(for: blueSlider)
        
        // RGB View
        rgbView.layer.cornerRadius = 10
        setColorRgbView()
    }
    
    // MARK: - IB Action
    @IBAction func rgbSlidersAction(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redLabel.text = sliderValueToString(for: sender)
        case 1:
            greenLabel.text = sliderValueToString(for: sender)
        case 2:
            blueLabel.text = sliderValueToString(for: sender)
        default:
            break
        }
        
        setColorRgbView()
    }
    
    // MARK: - Private Methods
    private func setColorRgbView() {
        rgbView.backgroundColor = UIColor( red: CGFloat(redSlider.value),
                                           green: CGFloat(greenSlider.value),
                                           blue: CGFloat(blueSlider.value),
                                           alpha: 1)
    }
    
    private func sliderValueToString(for slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

