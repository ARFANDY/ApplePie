//
//  Game.swift
//  Apple Pie
//
//  Created by Никита Акиндинов on 30.11.2020.
// 

struct Game {
    var word: String
    var mistakesRemaining: Int
    fileprivate var guessedLetters: [Character] = []
    
    var guessedWord: String {
        var wordToShow = ""
        for letter in word {
            if guessedLetters.contains(Character(letter.lowercased())) {
                wordToShow += String(letter)
            }
            else {
                wordToShow += "_"
            }
        }
        return wordToShow
    }
    
    init(word: String, mistakesRemaining: Int) {
        self.word = word
        self.mistakesRemaining = mistakesRemaining
    }
    
    mutating func playerGuessed(letter: Character) {
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        if !word.lowercased().contains(lowercasedLetter) {
            mistakesRemaining -= 1
        }
    }
}
