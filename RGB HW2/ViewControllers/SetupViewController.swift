//
//  ViewController.swift
//  RGB HW2
//
//  Created by Vladislav on 22.05.2020.
//  Copyright © 2020 Vladislav Cheremisov. All rights reserved.
//

import UIKit

protocol ColorMainViewProtocol {
    var colorMainView: UIColor { get }
}

protocol SetupViewControllerDelegate {
    func setColorMainView(_ color: UIColor)
}

class SetupViewController: UIViewController, ColorMainViewProtocol {

    // MARK: - IB Outlets
    @IBOutlet var setupView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!

	@IBOutlet var doneButtonLabel: UIButton!
    
    // MARK: - Public property
    var colorFromMainView: UIColor!
    
    var colorMainView: UIColor {
        setupView.backgroundColor ?? UIColor.white
    }
    
    var delegate: SetupViewControllerDelegate!
    
    // MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setUI()
        setElementsValue()
    }
    
    // MARK: - Touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Action
    @IBAction func rgbSlidersAction(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redLabel.text = sliderValueToString(for: sender)
            redTextField.text = sliderValueToString(for: sender)
        case 1:
            greenLabel.text = sliderValueToString(for: sender)
            greenTextField.text = sliderValueToString(for: sender)
        case 2:
            blueLabel.text = sliderValueToString(for: sender)
            blueTextField.text = sliderValueToString(for: sender)
        default:
            break
        }
        
        setColorView()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        delegate.setColorMainView(colorMainView)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setUI() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        setupView.layer.cornerRadius = 10
		doneButtonLabel.layer.cornerRadius = 10
        
        addToolbarForTextField()
    }
    
    private func setElementsValue() {
        redSlider.value = Float(colorFromMainView.rgba.red)
        greenSlider.value = Float(colorFromMainView.rgba.green)
        blueSlider.value = Float(colorFromMainView.rgba.blue)
        
        redLabel.text = sliderValueToString(for: redSlider)
        greenLabel.text = sliderValueToString(for: greenSlider)
        blueLabel.text = sliderValueToString(for: blueSlider)
        
        redTextField.text = sliderValueToString(for: redSlider)
        greenTextField.text = sliderValueToString(for: greenSlider)
        blueTextField.text = sliderValueToString(for: blueSlider)
        
        setColorView()
    }
    
    private func setColorView() {
        setupView.backgroundColor = UIColor( red: CGFloat(redSlider.value),
                                           green: CGFloat(greenSlider.value),
                                           blue: CGFloat(blueSlider.value),
                                           alpha: 1)
    }
    
    private func sliderValueToString(for slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
    
    private func addToolbarForTextField() {
        let toolbar = UIToolbar()
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneInput))
        
        toolbar.setItems([flexButton, doneButton], animated: true)
        toolbar.sizeToFit()
        
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneInput() {
        view.endEditing(true)
    }
}

// MARK: - Extensions
extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

extension SetupViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let textFieldText = textField.text ?? "0.00"
        let textFieldFloat = Float(textFieldText) ?? 0.0
        
        if textField.text == "" {
            textField.text = "0.00"
        }
        
        switch textFieldFloat {
        case let value where value < 0.01:
            textField.text = "0.00"
        case 1...:
            textField.text = "1.00"
        default:
            break
        }
        
        switch textField.tag {
        case 0:
            redSlider.value = Float(textField.text ?? "0.00") ?? 0.0
            redLabel.text = textField.text
        case 1:
            greenSlider.value = Float(textField.text ?? "0.00") ?? 0.0
            greenLabel.text = textField.text
        case 2:
            blueSlider.value = Float(textField.text ?? "0.00") ?? 0.0
            blueLabel.text = textField.text
        default:
            break
        }
        
        setColorView()
    }
}

