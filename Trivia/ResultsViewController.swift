//
//  ResultViewController.swift
//  Trivia
//
//  Created by Hugo Langeveld on 17/12/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//
import QuartzCore
import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // When the Textfield is used the submitbutton will be ready to use
    @IBAction func nameTextFieldChanged(_ sender: UITextField) {
        if sender.text != "" {
            submitButton.isEnabled = true
        }
    }
    
    // When submitbutton is tapped, the username and score are passed to the
    // HighScoreTableViewController
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        HighscoreController.shared.submitHighscore(name: usernameTextField.text!, score: correctAnswers)
        self.performSegue(withIdentifier: "HighscoreSegue", sender: nil)
    }
    
    var questions : [QuizElements] = []
    var correctAnswers = 0
    var totalQuestions = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Your score is \(correctAnswers) of the \(totalQuestions) questions. You should be proud."
        
    }
    
    // Passing the name of the player to the HighScoreTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HighscoreSegue" {
            let leaderBordViewController = segue.destination as! HighscoreTableViewController
            leaderBordViewController.newName = usernameTextField.text!
           
        }
    }
}
    










