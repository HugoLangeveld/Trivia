//
//  HighScoreTableViewController.swift
//  Trivia
//
//  Created by Hugo Langeveld on 18/12/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import UIKit

class HighscoreTableViewController: UITableViewController {
    
    var newName: String = ""
    var playerscore = [Result]()
    
    override func viewDidAppear(_ animated: Bool) {
        let playerscore = HighscoreController.shared.fetchHighscores()
        if let playerscore = playerscore {
            self.updateUI(with: playerscore)
        }
    }
    
    func updateUI(with playerscore: [Result]) {
        DispatchQueue.main.async {
            self.playerscore = playerscore.sorted {
                Int($1.score)! < Int($0.score)!
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerscore.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let playerscore = self.playerscore[indexPath.row]
        cell.textLabel?.text = playerscore.name
        cell.detailTextLabel?.text = String(playerscore.score)
    }
}
    


