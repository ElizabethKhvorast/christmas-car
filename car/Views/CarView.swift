//
//  CarView.swift
//  car
//
//  Created by Елизавета Хворост on 23/11/2022.
//

import UIKit

class CarView: UIView
{
    let carImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 60))
    var carPosition = CarPosition.center
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        let image = UIImage(named: "carIcon")
        self.carImageView.image = image
        self.carImageView.contentMode = .center
        self.addSubview(self.carImageView)
        self.carImageView.isHidden = true
        //
        let gestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        gestureLeft.direction = .left
        self.addGestureRecognizer(gestureLeft)
        let gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        gestureRight.direction = .right
        self.addGestureRecognizer(gestureRight)
    }
    
    private func updateCar()
    {
        var newPosition = self.carImageView.center
        switch self.carPosition {
        case .center:
            newPosition.x = self.bounds.width * 0.5
        case .left:
            newPosition.x = self.bounds.width * 0.33 * 0.5
        case .right:
            newPosition.x = self.bounds.width * 0.5 + self.bounds.width * 0.33
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

extension CarView: CarInterface
{
    func invalidate()
    {
        self.carImageView.isHidden = true
    }
    
    func checkIfCollisionDetected(with obstacles: [UIView]) -> Bool
    {
        let carFrame = self.carImageView.frame
        let treeFrames = obstacles.filter({$0 is UIImageView && $0.tag == GameConstants.treeTag}).compactMap({$0.frame})
        let snowmanViews = obstacles.filter({$0 is UIImageView && $0.tag == GameConstants.snowmanTag})
        for eachTreeFrame in treeFrames
        {
            if eachTreeFrame.intersects(carFrame)
            {
                return true
            }
        }
        for eachSnowmanView in snowmanViews
        {
            if eachSnowmanView.frame.intersects(carFrame)
            {
                eachSnowmanView.removeFromSuperview()
                ScoreManager.shared.showmanCollected()
            }
        }
        return false
    }
    
    func initiate()
    {
        self.carImageView.center = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height * 0.8)
        self.carImageView.isHidden = false
    }
}
