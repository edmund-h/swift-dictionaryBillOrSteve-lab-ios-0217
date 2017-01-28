//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Create your stored properties here
    
    var aboutSteveAndBill:  [ String : [String] ] = [:]
    var numCorrect = 0
    var numChances = 0
    var triesRemaining = 0
    var myFact: (String, String) = ("","")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDictionaries()
        resetChances()
        upkeep()
    }
    
    @IBOutlet weak var scoreCounter: UILabel!
    @IBOutlet weak var triesCounter: UILabel!
    @IBOutlet weak var factText: UILabel!
    @IBOutlet weak var billButton: UIButton!
    @IBOutlet weak var steveButton: UIButton!
    @IBOutlet weak var resetB: UIButton!
 
    
    @IBAction func guessSteve () {
        makeGuess ("Steve Jobs")
        upkeep()
    }
    @IBAction func guessBill () {
        makeGuess ("Bill Gates")
        upkeep()
    }
    @IBAction func resetButton () {
        numCorrect = 0
        loadDictionaries()
        resetChances()
        upkeep()
    }
    
    // Helper Functions
    
    func loadDictionaries () {
        
        let steveFacts = [
            "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
            "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
            "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
            "He was a pescetarian, meaning he ate no meat except for fish."
            ]
        
        let billFacts = [
            "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
            "He scored 1590 (out of 1600) on his SATs.",
            "His foundation spends more on global health each year than the United Nation's World Health Organization.",
            "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
            "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."
            ]
        
        aboutSteveAndBill.updateValue(steveFacts, forKey: "Steve Jobs")
        aboutSteveAndBill.updateValue(billFacts, forKey: "Bill Gates")
    }
    
    func upkeep() {
        if triesRemaining == 0 {
            winCondition()
        }else {
            scoreCounter.text = "\(numCorrect)"
            triesCounter.text = "\(triesRemaining)"
            steveButton.isHidden = false
            billButton.isHidden = false
            resetB.isHidden = true
            myFact = getRandomFact()
            factText.text = myFact.1
        }
        
    }
    
    func makeGuess (_ pers: String ) {
        triesRemaining -= 1
        if myFact.0 == pers { numCorrect += 1 }
    }
    
    func resetChances() {
        numChances = 0
        for stuff in aboutSteveAndBill.values {
            numChances += stuff.count
        }
        triesRemaining = numChances
    }
    
    func getRandomFact () -> (String, String) {
        
        let factIsAbout = randomPerson()
        
        var factIndex: Int
        var myFact: String
        if let myPersonsFacts = aboutSteveAndBill [factIsAbout] {
            
            if myPersonsFacts.isEmpty {
                return getRandomFact()
            }
            
            factIndex = randomIndex(myPersonsFacts.count )
            myFact = myPersonsFacts [factIndex]
            aboutSteveAndBill [factIsAbout]?.remove(at: factIndex)
            return (factIsAbout, myFact)
        } else {
            return ("","")
        }
    }
        
    func winCondition () {
        steveButton.isHidden = true
        billButton.isHidden = true
        factText.text = "Your score was \(numCorrect) out of \(numChances)!"
        resetB.isHidden = false
    }
    
    func randomIndex(_ input : Int) -> Int {
        return Int(arc4random_uniform(UInt32(input)))
    }
    
    func randomPerson() -> String {
        let randomNumber = randomIndex(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
}
