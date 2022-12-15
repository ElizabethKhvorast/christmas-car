//
//  ViewController.swift
//  car
//
//  Created by Елизавета Хворост on 13/11/2022.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var roadView: RoadView!    
    @IBOutlet weak var carView: CarView!
    //
    private var timer: Timer?
    
    //MARK: - Life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "Christmas Car"
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.initGame()
    }
    
    //MARK: - Helpers
    
    private func initGame()
    {
        self.showAlertWith(title: "Let's play!", message: nil, firstButtonTitle: "GO") { [weak self] in
            self?.startGame()
        }
    }
    
    private func startGame()
    {
        AudioPlayer.shared.playBackgroundMusic()
        ScoreManager.shared.reset()
        self.carView.initiate()
        self.timer = Timer.scheduledTimer(timeInterval: GameConstants.framesPerSecond,
                                          target: self,
                                          selector: #selector(update),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    private func stopGame()
    {
        AudioPlayer.shared.stop()
        self.timer?.invalidate()
        self.timer = nil
        self.roadView.invalidate()
        self.carView.invalidate()
        self.showAlertWith(title: "Game over.\n Do you wanna play again?",
                           message: nil,
                           firstButtonTitle: "No",
                           secondButtonTitle: "Yes",
                           firstCompletion: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }) { [weak self] in
            self?.startGame()
        }
    }
    
    @objc private func update()
    {
        ScoreManager.shared.tickScore()
        self.roadView.update()
        self.checkCollisions()
        self.navigationItem.title = "\(ScoreManager.shared.score)"
    }
    
    private func checkCollisions()
    {
        if self.carView.checkIfCollisionDetected(with: self.roadView.subviews)
        {
            let timeStart = ScoreManager.shared.timeStamp
            let score = ScoreManager.shared.score
            let timeEnd = Date()
            let scoreModel = ScoreModel(score: score, dateStart: timeStart, dateEnd: timeEnd)
            ScoreManager.shared.saveScore(scoreModel)
            self.stopGame()
        }
    }
}

