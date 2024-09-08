//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Srijan Shukla on 21/06/24.
//

import SwiftUI

struct LogoImage: View{
    var content: Image
    var body: some View{
        content
            .resizable()
            .clipShape(.rect)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
            .scaledToFit()
            .frame(width:120, height:120)
            .shadow(radius: 3)

    }
}

struct ContentView: View {
    
    private let choices = ["Rock", "Paper", "Scissors"]
    @State private var systemChoice = Int.random(in: 0...2)
    @State private var winOrLose: Bool = Bool.random()
    @State private var playerChoice = 0
    @State private var score = 0
    private let totalQuestions = 10
    @State private var isShowingRules = false
    @State private var isShowingScore = true
    @State private var noOfRounds = 0
    @State private var drawCondition = false
    
    func rockVsPaperVsScissor(_ choice1: Int, vs choice2: Int)->Int{
        switch (choice1, choice2){
        case (0, 1):
            return 1
            
        case (0, 2):
            return 0
            
        case (1, 0):
            return 1
            
        case (1, 2):
            return 2
            
        case (2, 0):
            return 0
            
        case (2, 1):
            return 2
        
        default:
            return -1
        }
    }
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 226/255, green: 201/255, blue: 246/255), location:0.5),
                .init(color: Color(red: 207/255, green: 159/255, blue: 255/255), location: 0.3)], center: .bottom, startRadius: 200, endRadius: 600)
            .ignoresSafeArea()
            
            VStack(){
                HStack(spacing: 20){
                    Spacer()
//                    Spacer()
//                    Spacer()
                    Spacer()
                    Text("🪨📄✂️")
                        .font(.largeTitle.bold())
                        .padding(10)
                        .background(.thinMaterial)
                        .clipShape(.capsule)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button{
                        isShowingRules = true
                    }label:{
                        Image(systemName: "pin.square")
                    }
                    .padding(7)
                    .font(.headline)
                    .foregroundColor(.black)
                    .background(Color(red: 238/255, green: 225/255, blue: 254/255))
                    .clipShape(.capsule)
                    
                }
                .padding(5)
                
                
                
                VStack{
                    Text("Computer's choice")
                        .font(.title.bold())
//                        .foregroundStyle(.thinMaterial)
                        .clipShape(.buttonBorder)
                    LogoImage(content: Image(choices[systemChoice]))
                }
                .padding(5)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(.regularMaterial)
                .clipShape(.buttonBorder)
                .padding(.horizontal ,40)
                .padding(.vertical, 20)
                
                Spacer()

                
                
                VStack{
//                    Text("You have to \(winOrLose ? "WIN" : "LOSE")")
                    Text("Make your choice")
                }
                    .font(.title2.bold())
                    .padding(20)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
                
                Spacer()
                HStack{
//                    Spacer()
                    ForEach(0..<3){ number in
                        VStack{
                            Button{
                                playerChose(number)
                            }label:{
                                LogoImage(content: Image(choices[number]))
                            }
                            
                            
//                            Text(choices[number])
//                                .foregroundStyle(.white)
//                                .font(.headline)
//                                .padding(5)
//                                .background(.purple)
//                                .clipShape(.rect(cornerRadius: 10))
                        }
//                        .background(.regularMaterial)
//                        .clipShape(.buttonBorder)
                    }
                }
                .padding(5)
                
                Text("Score : \(score)/\(noOfRounds)")
                    .font(.title3)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(.capsule)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
        .alert("Rules", isPresented: $isShowingRules){
            Button("Continue", role: .cancel){ }
        }message:{
            Text("Rock vs Paper : Paper wins \nRock vs Scissor : Rock wins\nScissor vs Paper : Scissor wins")
                .font(.headline)
        }
        .alert("DRAW", isPresented: $drawCondition){
            Button(noOfRounds==10 ? "New Game" : "Next Round", role: .cancel) { }
        } message:{
            Text("You made the same choice as computer")
        }
        .alert("\(winOrLose ? "WIN" : "LOSS")", isPresented: $isShowingScore){
//            Button(noOfRounds==10 ? "New Game" : "Next Round", role: .cancel) { }
            if(noOfRounds==10){
                Button("New Game", action: RestartGame)
            }
            else{
                Button("Next Round", action: nextRound)
            }
        }message:{
            Text("Your score is \(score) out of \(noOfRounds)")
        }
    }
    
    func playerChose(_ number: Int){
        playerChoice = number
        if rockVsPaperVsScissor(playerChoice, vs: systemChoice) == playerChoice{
            winOrLose = true
            score += 1
        }
        else if rockVsPaperVsScissor(playerChoice, vs: systemChoice) == -1{
            drawCondition = true
        }
        noOfRounds += 1
        isShowingScore = true
        if noOfRounds == 10{
            RestartGame()
        }
    }
    
    func nextRound(){
        systemChoice = Int.random(in: 0...2)
        winOrLose = Bool.random()
    }
    
    func RestartGame(){
        noOfRounds = 0
        systemChoice = Int.random(in: 0...2)
        winOrLose = Bool.random()
        score = 0
    }
}

#Preview {
    ContentView()
}
