//
//  IntroductionViewController.swift
//  Trivia
//
//  Created by Hugo Langeveld on 16/12/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    // Fetching questions via the GameController and performing a segue to the QuestionViewController
    @IBAction func startButtonTapped(_ sender: UIButton) {
        GameController.shared.fetchQuestions { (questions) in
            if let questions = questions {
                self.questions = questions
            }
        self.performSegue(withIdentifier: "startButtonPressed", sender: nil)
    }
    }
    
    // Declaring a new list of questions of type Item
    var questions : [QuizElements] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Passing the fetched question through to the QuestionViewController as a NavigationController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startButtonPressed" {
            let DestViewController = segue.destination as? UINavigationController
            let questionViewController = DestViewController?.topViewController as! QuestionViewController
            questionViewController.questions = self.questions
        }
    }
    
    @IBAction func unwindToIntroduction(segue: UIStoryboardSegue) {
    }

}
