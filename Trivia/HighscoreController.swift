//
//  HighscoreController.swift
//  Trivia
//
//  Created by Hugo Langeveld on 16/01/2019.
//  Copyright © 2019 Hugo Langeveld. All rights reserved.
//

import Foundation

class HighscoreController {
    static let shared = HighscoreController()
    
    // Making a url to store the scores of the players online at the link below and setting
    // the scores of the players in the variable Playerscore
    func fetchHighscores() -> [Result]? {
        let urlHighscores = URL(string: "https://ide50-hugolangeveld96.legacy.cs50.io:8080")!
        var leaderBordURL = urlHighscores.appendingPathComponent("leaderbord")
        var Highscores = [Result]()
        let task = URLSession.shared.dataTask(with: leaderBordURL) { (data, response, error) in
            guard let data = data else { return }
            do {
                let highScores = try JSONDecoder().decode([Result].self, from: data)
                Highscores = highScores
            } catch let jsonErr {
                print("The following error occured: ", jsonErr)
                return
            }
        }
        task.resume()
        while Highscores.isEmpty {
            continue
        }
        return Highscores
    }

    // Making a POST request to upload the fetched data to HighScoreTableViewController
    func submitHighscore(name: String, score: Int) {
        let baseURL = URL(string: "https://ide50-hugolangeveld96.legacy.cs50.io:8080/leaderbord")!
        var request = URLRequest(url: baseURL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(name)&score=\(score)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }





}

