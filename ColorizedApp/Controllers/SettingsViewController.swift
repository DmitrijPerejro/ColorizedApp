//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Perejro on 31/10/2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: @IBOutlets
    @IBOutlet weak var colorViewerView: UIView!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var sliderLabels: [UILabel]!
    @IBOutlet var sliderTextFields: [UITextField]!
    
    // MARK: public variables
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorViewerView.layer.cornerRadius = 16
        sliderTextFields.forEach { $0.delegate = self }
        setInitialState()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        delegate?.updateColor(color)
        dismiss(animated: true)
    }
    
    @IBAction func onChangeSliderValue(_ sender: UISlider) {
        sliderTextFields[sender.tag].text = toString(sender.value)
        sliderLabels[sender.tag].text = toString(sender.value)

        updateColorViewerView()
    }
    
    private func updateColorViewerView() {
        color = UIColor(
            red: toCGFloat(sliders[0].value),
            green: toCGFloat(sliders[1].value),
            blue: toCGFloat(sliders[2].value),
            alpha: 1
        )
        
        colorViewerView.backgroundColor = color
    }
    
    private func setInitialState() {
        let ciColor = CIColor(color: color)
        let colors = [ciColor.red, ciColor.green, ciColor.blue]
    
        for i in 0..<sliders.count {
            sliders[i].value = Float(colors[i])
            sliderLabels[i].text = toString(sliders[i].value)
            sliderTextFields[i].text = toString(sliders[i].value)
         }
        
        updateColorViewerView()
    }
    
    private func updateValues(_ tag: Int, _ value: Float) {
        sliders[tag].setValue(value, animated: true)
        sliderLabels[tag].text = toString(value)
        
        updateColorViewerView()
    }
    
}

// MARK: SettingsViewController helpers
private extension SettingsViewController {
    func toCGFloat(_ value: Float) -> CGFloat {
        CGFloat(value)
    }
    
    func toString(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
    
}

// MARK: SettingsViewController alert flow
private extension SettingsViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: SettingsViewController toolbar
private extension SettingsViewController {
    func makeToolBar(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(onDoneButton)
        )
         
        toolbar.items = [flexibleSpace, doneButton]
    }
    
    @objc func onDoneButton() {
        view.endEditing(true)
    }
}

// MARK: SettingsViewController UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        makeToolBar(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            showAlert(message: "Значение не может быть пустым")
            return
        }
        
        let value = Float(textField.text ?? "") ?? 0
        
        if value < 0 || value > 1 {
            showAlert(message: "Значение должно быть от 0 до 1")
            return
        }
        
        updateValues(textField.tag, value)
    }
}
