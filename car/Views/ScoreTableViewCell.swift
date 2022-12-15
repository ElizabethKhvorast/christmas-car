//
//  ScoreTableViewCell.swift
//  car
//
//  Created by Елизавета Хворост on 12/12/2022.
//

import UIKit

class ScoreTableViewCell: UITableViewCell
{
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.clear()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.clear()
    }
    
    private func clear()
    {
        self.scoreLabel.text = nil
        self.timeLabel.text = nil
    }
    
    func setup(with scoreModel: ScoreModel)
    {
        self.scoreLabel.text = "\(scoreModel.score)"
        self.timeLabel.text = scoreModel.dateStart.dateString(formatted: "HH:mm dd.MM.yyyy")
    }
}
