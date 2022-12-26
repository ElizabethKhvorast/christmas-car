//
//  AudioPlayer.swift
//  car
//
//  Created by Елизавета Хворост on 15/12/2022.
//

import AVFoundation

class AudioPlayer
{
    static let shared = AudioPlayer()
    static let availableSources = ["audio1",
                                   "audio2",
                                   "audio3"]
    var audioPlayer: AVAudioPlayer?
    var currentSource: String?
    
    init()
    {
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{}
        self.currentSource = AudioPlayer.availableSources.randomElement()
    }
    
    func playBackgroundMusic()
    {
        var source = self.currentSource
        if source == nil
        {
            source = AudioPlayer.availableSources.randomElement()
        }
        if let name = source
        {
            self.playMusicWith(name: name)
        }
    }
    
    func playMusicWith(name: String)
    {
        guard SettingsManager.shared.isMusicOn == true,
              let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            return
        }
        do
        {
            self.audioPlayer = try AVAudioPlayer(contentsOf:url)
            self.audioPlayer?.numberOfLoops = -1
            self.audioPlayer?.volume = SettingsManager.shared.musicVolume / 100.0
            self.audioPlayer?.prepareToPlay()
            self.audioPlayer?.play()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    func stop()
    {
        self.audioPlayer?.stop()
        self.audioPlayer = nil
        self.currentSource = AudioPlayer.availableSources.randomElement()
    }
}

