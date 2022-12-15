//
//  Constants.swift
//  car
//
//  Created by Елизавета Хворост on 23/11/2022.
//

import Foundation

public struct GameConstants
{
    static let framesPerSecond = 1.0 / 60.0
    static let speed = 4.0
    static let treeTag = 1
    static let snowmanTag = 2
}

public struct RoadConstants
{
    static let marksInScreen = 15.0
}

enum CarPosition: Int, Equatable
{
    case left = 0
    case center
    case right
    
    static func == (lhs: CarPosition, rhs: CarPosition) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}



