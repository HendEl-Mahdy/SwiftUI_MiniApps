//
//  GuessTheFlag_Home.swift
//  GuessTheFlag
//
//  Created by Hend El Mahdy on 21/06/2025.
//

import SwiftUI
import ConfettiSwiftUI

struct GuessTheFlag_Home: View {
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var questionCount = 1
    //@State private var rotatingButtonID: Int? = nil
    @State private var trigger = 0
    @State private var correctQuestion = 0
    @State private var message = ""
    @State private var selectedAnswer: Int? = nil
    
    @State private var Countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Monaco",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US",
        "Egypt"
    ].shuffled()
    
    private let flagColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack{
            AngularGradient(gradient: Gradient(colors: [
                Color(red: 0.1, green: 0.5, blue: 0.5),
                Color(red: 0.76, green: 0.8, blue: 0.26)
            ]), center: .center, angle: Angle(degrees: 50))
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap The Flag Of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text(Countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                    }.padding()
                    
                    LazyVGrid(columns: flagColumns, spacing: 20) {
                        ForEach(0..<4) { number in
                            Button{
                                //rotatingButtonID = number
                                flagTapped(number)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        askQuestion()
                                }
                            } label: {
                                Image(Countries[number])
                                    .frame(width: 150, height: 100)
                                    .clipShape(.capsule)
                                    .shadow(radius: 10)
                                    //.scaleEffect(rotatingButtonID == number ? 1.2 : 1.0)
                                    .overlay(
                                            Capsule()
                                                .stroke(
                                                    borderColor(for: number),
                                                    lineWidth: selectedAnswer != nil ? 6 : 0
                                                )
                                        )
                                    .animation(.easeOut(duration: 0.3), value: showingScore)
                            }
    
                        }
                    }.padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
                Spacer()
                
                Text("Score: \(correctQuestion)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    
                Spacer()
                
            }.padding()
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue") {}
            }message: {
                Text(message)
            }
            
            .confettiCannon(trigger: $trigger, num: 70, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
        }
    }
    
    private func flagTapped(_ number: Int) {
        selectedAnswer = number
        if number == correctAnswer {
            trigger += 1
            correctQuestion += 1
        }
    }
    
    private func askQuestion() {
        //rotatingButtonID = nil
        questionCount += 1
        selectedAnswer = nil
        if questionCount <= 5 {
            Countries.shuffle()
            correctAnswer = Int.random(in: 0...3)
            
        }else {
            scoreTitle = "🎉 Congratulations!"
            message = "You Are Finish Your Guess and Your Score is \(correctQuestion)"
            showingScore = true
            trigger = 0
            correctQuestion = 0
            questionCount = 1
        }
    }
    
    private func borderColor(for number: Int) -> Color {
        if selectedAnswer == nil {
            return .clear
        } else if number == correctAnswer {
            return .green
        } else if number == selectedAnswer {
            return .red
        } else {
            return .clear
        }
    }
}

#Preview {
    GuessTheFlag_Home()
}
