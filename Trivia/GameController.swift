//
//  TriviaController.swift
//  Trivia
//
//  Created by Hugo Langeveld on 17/12/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import Foundation
import UIKit
import HTMLString

class GameController {
    static let shared = GameController()
    
    // Decoding the API from Open Trivia DB API to use the data needed for the game
    func fetchQuestions(completion: @escaping ([QuizElements]?) -> Void) {
        let baseURL = URL(string: "https://opentdb.com/api.php?amount=10&category=22&difficulty=easy&type=multiple")!
        let task = URLSession.shared.dataTask(with: baseURL) { data, response, error in
            if let data = data, let quizElements = try? JSONDecoder().decode(Items.self, from: data) {
                completion(quizElements.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

