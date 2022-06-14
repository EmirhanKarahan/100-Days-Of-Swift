//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Emirhan KARAHAN on 12.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        askQuestion()
    }
    
    @objc func showScore(){
        let ac = UIAlertController(title: "Your score is 2", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default))
        present(ac, animated: true)
    }
    
    func askQuestion(action:UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionsAsked += 1
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        self.title = "Select \(countries[correctAnswer].uppercased()) -- Score: \(score) -- \(questionsAsked)/10"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title:String
        var actionTitle:String = "Continue"
        var message:String
      
        if sender.tag == correctAnswer {
            title = "Correct"
            message = ""
            score += 1
            
            if questionsAsked < 10 {
                askQuestion()
                return
            }
                
        }else{
            title = "Wrong!"
            message = "That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        if questionsAsked == 10 {
            title = "Game Over"
            message = "Your total score is \(score)."
            actionTitle = "Restart"
            questionsAsked = 0
            score = 0
            
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
}
