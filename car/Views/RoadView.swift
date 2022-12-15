//
//  RoadView.swift
//  car
//
//  Created by Елизавета Хворост on 23/11/2022.
//

import UIKit

class RoadView: UIView
{
    var lastTreePosition: CarPosition?
    var treesDelay = 2.0
    var treesTimeStamp = Date()
    
    var snowmanDelay = 3.0
    var snowmanTimeStamp = Date()
    //
    var roadMarksTimeStamp = Date()
    var roadMarksDelay: Double {
        get {
            return GameConstants.speed / RoadConstants.marksInScreen
        }
    }
    var frameOffset: Double {
        get {
            return self.bounds.height / GameConstants.speed * GameConstants.framesPerSecond
        }
    }
    
    override class func awakeFromNib()
    {
        super.awakeFromNib()
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
        //add snowman
        if Date().timeIntervalSince(self.snowmanTimeStamp) > self.snowmanDelay
        {
            self.snowmanTimeStamp = Date()
            self.addSnowman()
        }
        //
        for eachSubview in self.subviews
        {
            var frame = eachSubview.frame
            var origin = frame.origin
            origin.y += self.frameOffset
            frame.origin = origin
            eachSubview.frame = frame
        }
        //
        let subviews = self.subviews
        for eachSubview in subviews
        {
            let subviewYPosition = eachSubview.frame.origin.y
            if subviewYPosition > self.bounds.height
            {
                eachSubview.removeFromSuperview()
            }
        }
    }
    
    private func addRoadMarks()
    {
        let markHeight = 20.0
        let startY = -markHeight
        let startPoints = [CGPoint(x: self.bounds.width * 0.33, y: startY),
                           CGPoint(x: self.bounds.width * 0.66, y: startY)]
        for eachPoint in startPoints
        {
            let markSize = CGSize(width: 3, height: markHeight)
            let view = UIView(frame: CGRect(origin: eachPoint, size: markSize))
            view.backgroundColor = .white
            self.addSubview(view)
        }
    }
    
    private func addTree()
    {
        let randomLine = Int.random(in: 0...2)
        if let line = CarPosition(rawValue: randomLine)
        {
            self.lastTreePosition = line
            let treeSize = CGSize(width: 40, height: 50)
            var point = CGPoint.zero
            point.y = -treeSize.height
            switch line {
            case .center:
                point.x = self.bounds.width * 0.5
            case .left:
                point.x = self.bounds.width * 0.33 * 0.5
            case .right:
                point.x = self.bounds.width * 0.5 + self.bounds.width * 0.33
            }
            let treeView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: treeSize))
            treeView.image = UIImage(named: "treeIcon")
            treeView.contentMode = .center
            treeView.tag = GameConstants.treeTag
            self.addSubview(treeView)
            treeView.center = point
        }
    }
    
    private func addSnowman()
    {
        var lines: [CarPosition] = [.left, .center, .right]
        if let prevTreePosition = self.lastTreePosition, let index = lines.firstIndex(of: prevTreePosition)
        {
            lines.remove(at: index)
            self.lastTreePosition = nil
        }
        if let line = lines.randomElement()
        {
            let snowmanSize = CGSize(width: 40, height: 50)
            var point = CGPoint.zero
            point.y = -snowmanSize.height
            switch line {
            case .center:
                point.x = self.bounds.width * 0.5
            case .left:
                point.x = self.bounds.width * 0.33 * 0.5
            case .right:
                point.x = self.bounds.width * 0.5 + self.bounds.width * 0.33
            }
            let snowmanView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: snowmanSize))
            snowmanView.image = UIImage(named: "snowman")
            snowmanView.contentMode = .center
            snowmanView.tag = GameConstants.snowmanTag
            self.addSubview(snowmanView)
            snowmanView.center = point
        }
    }
}

//MARK: - RoadInterface

extension RoadView: RoadInterface
{
    func update()
    {
        self.updateRoad()
    }
    
    func invalidate()
    {
        let roadSubviews = self.subviews
        roadSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}
