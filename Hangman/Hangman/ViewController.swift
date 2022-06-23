//
//  ViewController.swift
//  Hangman
//
//  Created by Emirhan KARAHAN on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    var allWords = [String]()
    let icons = ["🥲","🤨","😔","☹️","😰","😱","🪦"]
    var timesGuessed:Int = 0 {
        didSet{
            if timesGuessed != 0{
                label.text = """
                \(icons[timesGuessed-1]) \(timesGuessed)/7
                """
            }
        }
    }
    var solution:String = ""
    var textFieldResult = Array("????????")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hangman"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guess Letter", style: .plain, target: self, action: #selector(getLetter))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        label.text = """
        😀 \(timesGuessed)/7
        """
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.borderStyle = .none
        
        // TODO: - Would be great if that part is async
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
        } else {
            allWords = ["silkworm"]
        }
        
        solution = allWords.randomElement()!
    }
    
    func restartGame(action:UIAlertAction){
        timesGuessed = 0
        solution = allWords.randomElement()!
        textFieldResult = Array("????????")
        label.text = """
        😀 \(timesGuessed)/7
        """
        textField.placeholder = "????????"
    }
    
    @objc func getLetter(){
        let ac = UIAlertController(title: "Guess a letter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] action in
            let answer = ac.textFields![0]
            if answer.text! != "" {
                self.submit(character: Array(answer.text!.lowercased())[0])
            }
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(character submittedCharacter:Character){
        var solution = Array(self.solution)
        var isFound:Bool = false
        
        for (index, char) in solution.enumerated(){
            if(char == submittedCharacter && char != "?"){
                textFieldResult[index] = char
                isFound = true
            }else{
                solution[index] = "?"
            }
        }
        
        if isFound{
            if self.solution == String(textFieldResult){
                let ac = UIAlertController(title: "Congratz! You've found the answer", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: restartGame))
                present(ac, animated: true)
                return
            }
            textField.placeholder = String(textFieldResult)
            return
        }
        timesGuessed += 1
        
        if timesGuessed >= 7{
            let ac = UIAlertController(title: "You just killed the guy. The solution was \(self.solution.uppercased())", message: "Just try your chance again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: restartGame))
            present(ac, animated: true)
        }
        
        
    }
    
    
}

