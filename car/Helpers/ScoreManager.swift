//
//  ScoreManager.swift
//  car
//
//  Created by Елизавета Хворост on 12/12/2022.
//

import Foundation

class ScoreManager
{
    private static let storeKey = "ScoreManagerStoreKey"
    static let shared = ScoreManager()
    
    private(set) var scoreDataSource = [ScoreModel]()
    private(set) var score: Int = 0
    private(set) var timeStamp = Date()
    
    init()
    {
        if let savedPerson = UserDefaults.standard.object(forKey: ScoreManager.storeKey) as? Data
        {
            let decoder = JSONDecoder()
            if let loadedArray = try? decoder.decode([ScoreModel].self, from: savedPerson)
            {
                self.scoreDataSource = loadedArray
            }
        }
    }
    
    func tickScore()
    {
        self.score += 1
    }
    
    func showmanCollected()
    {
        self.score += 100
    }
    
    func reset()
    {
        self.score = 0
        self.timeStamp = Date()
    }
    
    func saveScore(_ scoreModel: ScoreModel)
    {
        self.scoreDataSource.append(scoreModel)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.scoreDataSource)
        {
            UserDefaults.standard.set(encoded, forKey: ScoreManager.storeKey)
        }
    }
}
