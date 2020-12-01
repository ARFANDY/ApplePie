//
//  ViewController.swift
//  Apple Pie
//
//  Created by Никита Акиндинов on 26.11.2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentGame: Game!
    let mistakesAllowed = 7
    var listOfWords = [
        "Порш",
        "Мерседес",
        "БМВ",
        "Ауди",
        "Киа",
    ].shuffled()
    var totalLoses = 0 {
        didSet {
            newRound()
        }
    }
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    // MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        guard !listOfWords.isEmpty else {
            updateUI()
            enableButtons(false)
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, mistakesRemaining: mistakesAllowed)
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord: [String] = []
        for letter in currentGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.mistakesRemaining < 1 {
            totalLoses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func updateUI() {
        let image = "Tree\(currentGame.mistakesRemaining < 0 ? 0 : currentGame.mistakesRemaining < 8 ? currentGame.mistakesRemaining : 7)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выиграно: \(totalWins), проиграно: \(totalLoses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // MARK: - Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    

}

