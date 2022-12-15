//
//  RecordViewController.swift
//  car
//
//  Created by Елизавета Хворост on 16/11/2022.
//

import UIKit

class RecordViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [ScoreModel] = {
        let currentScores = ScoreManager.shared.scoreDataSource
        return currentScores.sorted()
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
    }
}

extension RecordViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as! ScoreTableViewCell
        cell.setup(with: self.dataSource[indexPath.row])
        return cell
    }
}
