//
//  TriviaQuestions.swift
//  Trivia
//
//  Created by Hugo Langeveld on 16/12/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import Foundation

// Declaring all the needed elements for in the quiz
struct QuizElements: Decodable {
    var correct_answer: String
    var incorrect_answers: [String]
    var question : String
    var type: String
    
}

struct Items: Decodable {
    let responseCode: Int
    let items: [QuizElements]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case items = "results"
    }
}

// Declaring all the needed elements for a player to play the game
struct Result: Codable {
    var id: Int
    var name: String
    var score: String
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        score = json["score"] as? String ?? ""
    }
}

