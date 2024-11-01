//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Perejro on 31/10/2024.
//

import UIKit

let initialValue: [String: Float] = [
    "red": 0.8,
    "green": 0.2,
    "blue": 0.5
]

final class ViewController: UIViewController {
    @IBOutlet weak var colorViewerView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redSliderValueLabel: UILabel!
    @IBOutlet weak var greenSliderValueLabel: UILabel!
    @IBOutlet weak var blueSliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorViewerView.layer.cornerRadius = 16
        setInitialState()
    }
    
    @IBAction func onChangeSliderValue(_ sender: UISlider) {
        switch sender.tag {
        case 0 :
            changeSliderValueLabel(label: redSliderValueLabel, value: sender.value)
        case 1:
            changeSliderValueLabel(label: greenSliderValueLabel, value: sender.value)
        default:
            changeSliderValueLabel(label: blueSliderValueLabel, value: sender.value)
        }
        
        updateColor()
    }
    
    private func changeSliderValueLabel(label: UILabel, value: Float) {
        label.text = toString(value)
    }
    
    private func updateColor() {
        colorViewerView.backgroundColor = UIColor(
            red: toCGFloat(redSlider.value),
            green: toCGFloat(greenSlider.value),
            blue: toCGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setInitialState() {
        redSlider.value = initialValue["red"]!
        greenSlider.value = initialValue["green"]!
        blueSlider.value = initialValue["blue"]!
        
        changeSliderValueLabel(label: redSliderValueLabel, value: redSlider.value)
        changeSliderValueLabel(label: greenSliderValueLabel, value: greenSlider.value)
        changeSliderValueLabel(label: blueSliderValueLabel, value: blueSlider.value)
        
        updateColor()
    }
    
    private func toCGFloat(_ value: Float) -> CGFloat {
        CGFloat(value)
    }
    
    private func toString(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
    
}

