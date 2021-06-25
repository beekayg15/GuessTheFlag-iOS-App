//
//  ViewController.swift
//  SampleProject2
//
//  Created by Barath Ganesh Kumar on 08/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries : [String] = []
    var score : Int = 0
    var correctAnswer : Int = 0
    var question : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain,  target: self, action: #selector(displayScore))
        
        setNewGame(action: nil)
    }
    
    func setNewGame(action: UIAlertAction!) {
        countries = []
        score = 0
        question = 0
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("uk")
        countries.append("us")
        countries.append("spain")
        countries.append("russia")
        countries.sort()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        title = "\(question+1). "+countries[correctAnswer].uppercased()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    func endGame(action: UIAlertAction!) {
        exit(0)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title : String
        let choosenAnswer : Int = sender.tag
        
        if choosenAnswer == correctAnswer {
            title = "Correct"
            score += 1
            question += 1
            
        } else {
            title = "Wrong"
            question += 1
            score -= 1
            
        }
        
        if question == 10 {
            let acc = UIAlertController(title: "Completed", message: "You have scored \(score) on 10", preferredStyle: .alert)
            
            acc.addAction(UIAlertAction(title: "New Game", style: .default, handler: setNewGame))
            acc.addAction(UIAlertAction(title: "End Game", style: .default, handler: endGame))
            
            present(acc, animated: true)
            
        } else {
            var mess = "Your Score is \(score)"
            
            if title == "Wrong" {
                mess += "\nYou have chosen the flag of " + (countries[choosenAnswer]).uppercased()
            }
            
            let ac = UIAlertController(title: title, message: mess, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: setNewGame))
            ac.addAction(UIAlertAction(title: "End Game", style: .default, handler: endGame))
            
            present(ac, animated: true)
            
        }
        
    }
    
    @objc func displayScore() {
        let ac = UIAlertController(title: "Score", message: "\(score) / \(question)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue",style: .default))
        present(ac, animated: true)
        
    }
    
}

