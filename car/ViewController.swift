//
//  ViewController.swift
//  car
//
//  Created by Елизавета Хворост on 13/11/2022.
//

import UIKit

class ViewController: UIViewController
{
    enum CarPosition: Int {
        case left = 0
        case center
        case right
    }
        
    @IBOutlet weak var roadView: UIView!    
    @IBOutlet weak var carView: UIView!
    //
    let carImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 60))
    var carPosition = CarPosition.center
    //
    private var timer: Timer?
    //
    let framesPerSecond = 1.0 / 60.0
    let gameSpeed = 4.0
    var frameOffset: Double {
        get {
            return self.view.bounds.height / self.gameSpeed * self.framesPerSecond
        }
    }
    //
    var marksInScreen = 15.0
    var roadMarksDelay: Double {
        get {
            return self.gameSpeed / self.marksInScreen
        }
    }
    var roadMarksTimeStamp = Date()
    //
    var treesDelay = 1.0
    var treesTimeStamp = Date()
    
    //MARK: - Life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "Christmas Car"
        self.navigationItem.hidesBackButton = true
        // имейжэ скрыт (ис хиден), пока не наэмем летс гоу
        let image = UIImage(named: "carIcon")
        self.carImageView.image = image
        self.carImageView.contentMode = .center
        self.carView.addSubview(self.carImageView)
        self.carImageView.isHidden = true
        //
        let gestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        gestureLeft.direction = .left
        self.carView.addGestureRecognizer(gestureLeft)
        let gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        gestureRight.direction = .right
        self.carView.addGestureRecognizer(gestureRight)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.initGame()
    }
    
    //MARK: - Helpers
    
    private func initGame()
    {
        let alert = UIAlertController(title: "Let's play!",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "GO", style: .default, handler: { [weak self] action in
            self?.startGame()
        }))
        self.present(alert, animated: true)
    }
    
    private func startGame()
    {
        self.carImageView.center = CGPoint(x: self.carView.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.8)
        self.carImageView.isHidden = false
        self.roadMarksTimeStamp = Date()
        self.treesTimeStamp = Date()
        self.timer = Timer.scheduledTimer(timeInterval: self.framesPerSecond,
                                          target: self,
                                          selector: #selector(update),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    private func stopGame()
    {
        self.timer?.invalidate()
        self.timer = nil
        //
        let roadSubviews = self.roadView.subviews
        roadSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
        //
        self.carImageView.isHidden = true
        let alert = UIAlertController(title: "Game over.\n Do you wanna play again?",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.startGame()
        }))
        self.present(alert, animated: true)
    }
    
    @objc private func update()
    {
        self.updateRoad()
        self.checkCollisions()
    }
    
    private func checkCollisions()
    {
        let carFrame = self.carImageView.frame
        let treeFrames = self.roadView.subviews.filter({$0 is UIImageView}).compactMap({$0.frame})
        for eachTreeFrame in treeFrames
        {
            if eachTreeFrame.intersects(carFrame)
            {
                self.stopGame()
            }
        }
    }
    
    private func addTree()
    {
        let randomLine = Int.random(in: 0...2)
        if let line = CarPosition(rawValue: randomLine)
        {
            let treeSize = CGSize(width: 40, height: 50)
            var point = CGPoint.zero
            point.y = -treeSize.height
            switch line {
            case .center:
                point.x = self.roadView.bounds.width * 0.5
            case .left:
                point.x = self.roadView.bounds.width * 0.33 * 0.5
            case .right:
                point.x = self.roadView.bounds.width * 0.5 + self.roadView.bounds.width * 0.33
            }
            let treeView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: treeSize))
            treeView.image = UIImage(named: "treeIcon")
            treeView.contentMode = .center
            self.roadView.addSubview(treeView)
            treeView.center = point
        }
    }
    
    private func updateRoad()
    {
        //add mark
        if Date().timeIntervalSince(self.roadMarksTimeStamp) > self.roadMarksDelay
        {
            self.roadMarksTimeStamp = Date()
            self.addRoadMarks()
        }
        //add tree
        if Date().timeIntervalSince(self.treesTimeStamp) > self.treesDelay
        {
            self.treesTimeStamp = Date()
            self.addTree()
        }
        //
        for eachSubview in self.roadView.subviews
        {
            var frame = eachSubview.frame
            var origin = frame.origin
            origin.y += self.frameOffset
            frame.origin = origin
            eachSubview.frame = frame
        }
        //
        let subviews = self.roadView.subviews
        for eachSubview in subviews
        {
            let subviewYPosition = eachSubview.frame.origin.y
            if subviewYPosition > self.roadView.bounds.height
            {
                eachSubview.removeFromSuperview()
            }
        }
    }
    
    private func addRoadMarks()
    {
        let markHeight = 20.0
        let startY = -markHeight
        let startPoints = [CGPoint(x: self.roadView.bounds.width * 0.33, y: startY),
                           CGPoint(x: self.roadView.bounds.width * 0.66, y: startY)]
        for eachPoint in startPoints
        {
            let markSize = CGSize(width: 3, height: markHeight)
            let view = UIView(frame: CGRect(origin: eachPoint, size: markSize))
            view.backgroundColor = .white
            self.roadView.addSubview(view)
        }
    }
    
    private func updateCar()
    {
        var newPosition = self.carImageView.center
        switch self.carPosition {
        case .center:
            newPosition.x = self.carView.bounds.width * 0.5
        case .left:
            newPosition.x = self.carView.bounds.width * 0.33 * 0.5
        case .right:
            newPosition.x = self.carView.bounds.width * 0.5 + self.carView.bounds.width * 0.33
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.carImageView.center = newPosition
        })
    }
    
    //MARK: - Actions
    
    @objc private func swipeLeft()
    {
        switch self.carPosition {
        case .right:
            self.carPosition = .center
        case .left:
            return
        case .center:
            self.carPosition = .left
        }
        self.updateCar()
    }
    
    @objc private func swipeRight()
    {
        switch self.carPosition {
        case .right:
            return
        case .left:
            self.carPosition = .center
        case .center:
            self.carPosition = .right
        }
        self.updateCar()
    }
}

