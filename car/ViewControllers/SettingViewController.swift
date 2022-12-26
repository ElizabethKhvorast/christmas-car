//
//  SettingViewController.swift
//  car
//
//  Created by Елизавета Хворост on 24/11/2022.
//

import UIKit

class SettingViewController: UIViewController
{
    @IBOutlet weak var recordBackground: UIImageView!
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.volumeSlider.value = SettingsManager.shared.musicVolume
        self.musicSwitch.isOn = SettingsManager.shared.isMusicOn
    }
    
    @IBAction func musicSwitchDidChanged(_ sender: UISwitch)
    {
        let isMusicOn = sender.isOn
        SettingsManager.shared.isMusicOn = isMusicOn
    }
    
    @IBAction func sliderDidChanged(_ sender: UISlider)
    {
        let volume = sender.value
        SettingsManager.shared.musicVolume = volume
    }
    
    @IBAction func contactPressed(_ sender: Any)
    {
        if let url = URL(string: "mailto:hvorostliza@gmail.com"), UIApplication.shared.canOpenURL(url) == true
        {
            UIApplication.shared.open(url)
        }
        else
        {
            self.showAlertWith(title: "Error",
                               message: "There is no mailing app",
                               firstButtonTitle: "Ok",
                               firstCompletion: nil)
        }
    }
}
