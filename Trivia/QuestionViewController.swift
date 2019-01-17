//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Hugo Langeveld on 16/12/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import UIKit
import HTMLString


class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!

    var questions : [QuizElements] = []
    var correctAnswers = 0
    var questionIndex = 0
    
    // When answerbuttons are pressed, the correctness is checked and moved on to a new question
    @IBAction func answerButton1Pressed(_ sender: UIButton) {
        if answerButton1.currentTitle == questions[questionIndex].correct_answer {
            correctAnswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    @IBAction func answerButton2Pressed(_ sender: UIButton) {
        if answerButton2.currentTitle == questions[questionIndex].correct_answer {
            correctAnswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    @IBAction func answerButton3Pressed(_ sender: UIButton) {
        if answerButton3.currentTitle == questions[questionIndex].correct_answer {
            correctAnswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    @IBAction func answerButton4Pressed(_ sender: UIButton) {
        if answerButton4.currentTitle == questions[questionIndex].correct_answer {
            correctAnswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    
    // Moving to a new question
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI(with: questions)
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    // Appending the correct and incorrect answers to a list called answers and making
    // variables like currentQuestions to organize.
    func updateUI(with questions: [QuizElements]) {
        DispatchQueue.main.async {
            self.questions = questions
            let currentQuestion = questions[self.questionIndex]
            self.questionLabel.text = currentQuestion.question.removingHTMLEntities
            self.navigationItem.title = "Question \(self.questionIndex + 1) of \(questions.count)"
            if currentQuestion.type == "multiple" {
                var answers : [String] = currentQuestion.incorrect_answers
                answers.append(currentQuestion.correct_answer)
                answers = answers.shuffled()
                self.updateAnswerButtons(with: answers)
            } else {
                print("Error, try again")
            }
        }
    }
    
    // Updating the title of the answer buttons
    func updateAnswerButtons(with answer: [String]) {
        answerButton1.setTitle(answer[0].removingHTMLEntities, for: .normal)
        answerButton2.setTitle(answer[1].removingHTMLEntities, for: .normal)
        answerButton3.setTitle(answer[2].removingHTMLEntities, for: .normal)
        answerButton4.setTitle(answer[3].removingHTMLEntities, for: .normal)
    }
    
    // updating the user interface with the current question
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        GameController.shared.fetchQuestions { (questions) in
            if let questions = questions {
                self.updateUI(with: questions)
            }
        }
        answerButton1.layer.cornerRadius = 15.0
        answerButton2.layer.cornerRadius = 15.0
        answerButton3.layer.cornerRadius = 15.0
        answerButton4.layer.cornerRadius = 15.0
    }
    
    // Passing the fetched question, correct answers and total amount of questions through to the
    // ResultViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.questions = questions
            resultsViewController.correctAnswers = correctAnswers
            resultsViewController.totalQuestions = questionIndex
        }
    }
}
