//
//  ScoreModel.swift
//  car
//
//  Created by Елизавета Хворост on 12/12/2022.
//

import Foundation

struct ScoreModel: Codable
{
    let score: Int
    let dateStart: Date
    let dateEnd: Date
}

extension ScoreModel: Comparable, Equatable
{
    static func < (lhs: ScoreModel, rhs: ScoreModel) -> Bool {
        return lhs.dateStart > rhs.dateStart
    }
    
    static func == (lhs: ScoreModel, rhs: ScoreModel) -> Bool {
        return lhs.dateStart == rhs.dateStart && lhs.score == rhs.score && lhs.dateEnd == rhs.dateEnd
    }
}
