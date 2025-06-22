//
//  GuessTheFlagViewModel.swift
//  GuessTheFlag
//
//  Created by Hend El Mahdy on 22/06/2025.
//

import SwiftUI

class GuessTheFlagViewModel: ObservableObject {
    @Published var Countries = [
        "Estonia","France","Germany","Ireland",
        "Italy","Monaco","Nigeria","Poland",
        "Spain","UK","Ukraine","US","Egypt"
    ].shuffled()
    
    @Published var correctAnswer = Int.random(in: 0...3)
    @Published var selectedAnswer: Int? = nil
    @Published var score = 0
    @Published var questionCount = 1
    @Published var showingScore = false
    @Published var scoreTitle = ""
    @Published var message = ""
    @Published var trigger = 0
    
    let maxQuestions = 5
    let numberOfChoices = 4
    let confettiCount = 70
    
    func flagTapped(_ number: Int) {
        selectedAnswer = number
        if number == correctAnswer {
            trigger += 1
            score += 1
        }
    }
    
    func askNextQuestion() {
        //rotatingButtonID = nil
        questionCount += 1
        selectedAnswer = nil
        
        if questionCount > maxQuestions {
            scoreTitle = "🎉 Congratulations!"
            message = "You Are Finish Your Guess and Your Score is \(score)"
            showingScore = true
            resetGame()
            
        }else {
            Countries.shuffle()
            correctAnswer = Int.random(in: 0..<numberOfChoices)
        }
    }
    
    private func resetGame() {
        trigger = 0
        score = 0
        questionCount = 1
    }
    
    func borderColor(for number: Int) -> Color {
        guard let selected = selectedAnswer else {return .clear}
        
        if number == correctAnswer {
            return .green
        } else if number == selected {
            return .red
        } else {
            return .clear
        }
    }
}
