//
//  AppViewController.swift
//  ColorizedApp
//
//  Created by Perejro on 16/11/2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func updateColor(_ color: UIColor)
}

final class AppViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsViewController = segue.destination as? SettingsViewController {
            settingsViewController.delegate = self
            settingsViewController.color = view.backgroundColor
        }
    }
}

// MARK: SettingsViewControllerDelegate
extension AppViewController: SettingsViewControllerDelegate {
    func updateColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
