//
//  ContentView.swift
//  Challenge 2
//
//  Created by Student on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    
    @State private var score = 0
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.score += 1

        } else {
            scoreTitle = "Wrong!!! Thats the flag of \(countries[number])"
            self.score += 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    struct ContwntView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: { self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                HStack {
                    Text("Your score is: ")
                        .foregroundColor(.yellow)
                        .font(.title)
                        .fontWeight(.black)
                    
                    Text("/(self.score)")
                        .foregroundColor(.red)
                        .font(.title)
                        .fontWeight(.black)
                }
                Spacer()
            }
        }.alert(isPresented: $showingScore) { () -> Alert in
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) { self.askQuestion()
            })
        }
    }
}

