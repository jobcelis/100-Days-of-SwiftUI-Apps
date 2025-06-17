//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Job Celis


import SwiftUI

struct ContentView: View {
    
    // Shuffled country names from Assets
    @State var countries = ["US", "UK", "Germany", "France", "Ukraine", "Ireland", "Italy", "Estonia", "Nigeria", "Poland", "Spain"].shuffled()
    
    // Verify the correct country image (randomized).
    @State var correctAnswer = Int.random(in: 0...2)
    
    // Properties to indicate alert visibility, and store the title displayed in the alert
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    // Property for the scoring part
    @State private var score = 0
    
    // Animation properties for each flag
    @State private var selectedFlags = [0.0, 0.0, 0.0]

    var body: some View {
        
        // Background color
        ZStack {
            LinearGradient(colors: [.blue, .gray, .orange], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            // Main Title / Score Board
            VStack {
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Text("Score: \(score)")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.black)
                
                
                // Flag spacing
                VStack(spacing: 30) {
                    VStack {
                        
                        // Text for telling players what to do/color of each text line
                        Spacer()
                        Text("Tap the flag of")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    // How many flags will appear on screen
                    ForEach(0..<3) { number in
                        
                        // Button for tapping correct flag / flag styling
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(
                            .degrees(selectedFlags[number]), axis: (x: 0, y: 1, z: 0)
                        )
                    }
                    // Spacing between the main title and the flags
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
        // Shows alert after player picks flag
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    // Displays a correct or wrong message after a flag was tapped
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1 /// Increment the score for a correct answer
            scoreTitle = "Correct! 👍🏼"
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                selectedFlags[number] += 360
            }
        } else {
            score -= 1 /// Decrement the score for a wrong answer
            scoreTitle = """
                        Wrong! 👎🏼
                        That's the flag of \(countries[number])
                        """
        }
        showingScore = true
    }
    
    
    // Reshuffles the countries for a new answer
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false /// Reset showingScore to hide the previous alert
        selectedFlags = [0.0, 0.0, 0.0]
    }
}



#Preview {
    ContentView()
}


