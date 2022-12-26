//
//  SettingsManager.swift
//  car
//
//  Created by Елизавета Хворост on 26/12/2022.
//

import Foundation

class SettingsManager
{
    static let shared = SettingsManager()
    
    private static let isMusicOnKey = "SettingsManagerIsMusicOnKey"
    private static let volumeKey = "SettingsManagerVolumeKey"
    
    var isMusicOn = true {
        didSet {
            UserDefaults.standard.set(self.isMusicOn, forKey: SettingsManager.isMusicOnKey)
        }
    }
    var musicVolume: Float = 100.0 {
        didSet {
            UserDefaults.standard.set(self.musicVolume, forKey: SettingsManager.volumeKey)
        }
    }
    
    init()
    {
        if let _ = UserDefaults.standard.object(forKey: SettingsManager.isMusicOnKey)
        {
            self.isMusicOn = UserDefaults.standard.bool(forKey: SettingsManager.isMusicOnKey)
        }
        else
        {
            UserDefaults.standard.set(self.isMusicOn, forKey: SettingsManager.isMusicOnKey)
        }
        if let _ = UserDefaults.standard.object(forKey: SettingsManager.volumeKey)
        {
            self.musicVolume = UserDefaults.standard.float(forKey: SettingsManager.volumeKey)
        }
        else
        {
            UserDefaults.standard.set(self.musicVolume, forKey: SettingsManager.volumeKey)
        }
    }
}
