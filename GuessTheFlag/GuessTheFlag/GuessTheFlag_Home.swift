//
//  GuessTheFlag_Home.swift
//  GuessTheFlag
//
//  Created by Hend El Mahdy on 21/06/2025.
//

import SwiftUI
import ConfettiSwiftUI

struct GuessTheFlag_Home: View {
    @StateObject private var viewModel = GuessTheFlagViewModel()
    
    private let flagColumns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
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
                        
                        Text(viewModel.Countries[viewModel.correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                    }.padding()
                    
                    LazyVGrid(columns: flagColumns, spacing: 20) {
                        ForEach(0..<viewModel.numberOfChoices, id: \.self) { index in
                            FlagButtonView(
                                imageName: viewModel.Countries[index],
                                borderColor: viewModel.borderColor(for: index)) {
                                    viewModel.flagTapped(index)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        viewModel.askNextQuestion()
                                    }
                                }
                        }
                    }.padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Spacer()
                
            }.padding()
            
                .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
                    Button("Continue") {}
                }message: {
                    Text(viewModel.message)
                }
            
                .confettiCannon(
                    trigger: $viewModel.trigger,
                    num: viewModel.confettiCount,
                    openingAngle: Angle(
                        degrees: 0
                    ),
                    closingAngle: Angle(degrees: 360),
                    radius: 200
                )
        }
    }
}

struct FlagButtonView: View {
    let imageName: String
    let borderColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 100)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(borderColor, lineWidth: borderColor == .clear ? 0 : 6)
                )
                .shadow(radius: 10)
            
        }
    }
}

#Preview {
    GuessTheFlag_Home()
}
