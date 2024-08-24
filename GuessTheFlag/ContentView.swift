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
    
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    struct FlagImage: View {
        var number: Int
        var countries: [String]
        var action: (Int) -> Void
        
        var body: some View {
            
            Button {
                action(number)
            } label: {
                Image(countries[number])
                    .clipShape(.capsule)
                    .shadow(radius: 5)
            }
        }
    }
    
    
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
                        if number == correctAnswer {
                            FlagImage(number: number, countries: countries, action: flagTapped)
                                .rotation3DEffect(.degrees(animationAmount),axis: (x: 0, y: 0, z: 1))
                                .accessibilityLabel(labels[countries[number], default: "Unknown Flag"])
                        } else {
                            FlagImage(number: number, countries: countries, action: flagTapped)
                                .opacity(opacityAmount)
                                .accessibilityLabel(labels[countries[number], default: "Unknown Flag"])
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
            
            withAnimation(.spring(duration: 0.8, bounce: 0.3)) {
                animationAmount += 360
            }
            
            withAnimation {
                opacityAmount = 0.25
            }
            
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
        opacityAmount = 1
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
