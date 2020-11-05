//
//  ContentView.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2020-10-13.
//

import SwiftUI

let WELLCOME_MESSAGE = "Hey there! Guess the sequence!"
let PLAYING_SEQUENCE = "Playing the Sequence..."
let MAJOR_THIRD = "Guessed Major Third"
let MINOR_THIRD = "Guessed Minor Third"
let CORRECT_GUESS = "You guessed correctly! Hurray!"
let INCORRECT_GUESS = "You guessed wrongly! Looser!"

enum Note: UInt8, CaseIterable {
    case MajorThird = 4
    case MinorThird = 3
}

struct ContentView: View {
    @State var score: Int = 0
    @State var message: String = WELLCOME_MESSAGE
    @State var intervalPlayer: IntervalPlayer! = IntervalPlayer.init(root: UInt8.random(in: 60...71), interval: Note.allCases.randomElement()!.rawValue)
    
    fileprivate func processGuess(note: Note, resetAction: (String) -> Void) {
        var result: String = ""
        if self.intervalPlayer.interval == note.rawValue {
            self.score += 1
            result = CORRECT_GUESS
        } else {
            result = INCORRECT_GUESS
        }
        resetAction(result)
    }
    
    var body: some View {
        let resetAction: (String) -> Void = { message in
            self.message = message
            self.intervalPlayer.setInterval(root: UInt8.random(in: 60...71), interval: Note.allCases.randomElement()!.rawValue)
        }
        VStack {
            Text("\(self.message)")
                .padding()
            Button("Play Sequence", action: {
                self.message = PLAYING_SEQUENCE
                self.intervalPlayer.playInterval()
            })
            .padding(.bottom)
            HStack {
                Button("Guess Major Third", action: {
                    self.message = MAJOR_THIRD
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                        processGuess(note: Note.MajorThird, resetAction: resetAction)
                    }
                })
                .padding(.trailing)
                Button("Guess Minor Third", action: {
                    self.message = MINOR_THIRD;
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                        processGuess(note: Note.MinorThird, resetAction: resetAction)
                    }
                })
                .padding(.leading)
            }
            Text("Your score is \(self.score)")
                .padding(.top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
