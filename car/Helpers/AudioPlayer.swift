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
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic()
    {
        self.playMusicWith(name: "chris-rea-driving-home-for-christmas")
    }
    
    func playMusicWith(name: String)
    {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            return
        }
        let url = NSURL(fileURLWithPath: path)
        do
        {
            self.audioPlayer = try AVAudioPlayer(contentsOf:url as URL)
            self.audioPlayer!.numberOfLoops = -1
            self.audioPlayer!.prepareToPlay()
            self.audioPlayer!.play()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    func stop()
    {
        self.audioPlayer?.stop()
    }
}

