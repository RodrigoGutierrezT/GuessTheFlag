//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rodrigo on 17-06-24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var titleScore = ""
    @State private var score = 0
    @State private var currentAnswer = ""
    
    private var maxAttemps = 8
    @State private var currentAttempt = 1
    
    @State private var showingGameFinished = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Text("Attemp \(currentAttempt - 1)/\(maxAttemps)")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap de flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(titleScore, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if titleScore == "Wrong"{
                Text("Wrong! thats the flag of \(currentAnswer)")
            }
            Text("Your score is \(score)")
        }
        .alert("You Finished!",isPresented: $showingGameFinished) {
            Button("Play Again?", action: resetGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if correctAnswer == number {
            titleScore = "Correct"
            score += 1
        } else {
            titleScore = "Wrong"
            currentAnswer = countries[number]
        }
        
        currentAttempt += 1
        
        if currentAttempt <= maxAttemps{
            showingScore = true
        } else {
            showingGameFinished = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentAnswer = ""
    }
    
    func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentAnswer = ""
        currentAttempt = 1
        score = 0
    }
}

#Preview {
    ContentView()
}
