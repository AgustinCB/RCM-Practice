//
//  ContentView.swift
//  RCM Practice
//

import SwiftUI

fileprivate struct Grade1IntervalExerciseMessages{
    static let WELLCOME_MESSAGE = "Hey there! Guess the interval!"
    static let PLAYING_SEQUENCE = "Playing the Sequence..."
    static let MAJOR_THIRD = "Guessed Major Third"
    static let MINOR_THIRD = "Guessed Minor Third"
    static let CORRECT_GUESS = "You guessed correctly! Hurray!"
    static let INCORRECT_GUESS = "You guessed wrongly! Looser!"
}

fileprivate enum Note: UInt8, CaseIterable {
    case MajorThird = 4
    case MinorThird = 3
}

struct Grade1IntervalExercise: View {
    @State var score: Int = 0
    @State var message: String = Grade1IntervalExerciseMessages.WELLCOME_MESSAGE
    @State var intervalPlayer: IntervalPlayer! = IntervalPlayer.init(root: UInt8.random(in: 60...71), interval: Note.allCases.randomElement()!.rawValue)
    
    fileprivate func processGuess(note: Note) {
        var result: String = ""
        if self.intervalPlayer.interval == note.rawValue {
            self.score += 1
            result = Grade1IntervalExerciseMessages.CORRECT_GUESS
        } else {
            result = Grade1IntervalExerciseMessages.INCORRECT_GUESS
        }
        self.message = result
        self.intervalPlayer.setInterval(root: UInt8.random(in: 60...71), interval: Note.allCases.randomElement()!.rawValue)
    }
    
    var body: some View {
        VStack {
            Text("\(self.message)")
                .padding()
            Button("Play Sequence", action: {
                self.message = Grade1IntervalExerciseMessages.PLAYING_SEQUENCE
                self.intervalPlayer.playInterval()
            })
            .padding(.bottom)
            HStack {
                Button("Guess Major Third", action: {
                    self.message = Grade1IntervalExerciseMessages.MAJOR_THIRD
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        processGuess(note: Note.MajorThird)
                    }
                })
                .padding(.trailing)
                Button("Guess Minor Third", action: {
                    self.message = Grade1IntervalExerciseMessages.MINOR_THIRD;
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        processGuess(note: Note.MinorThird)
                    }
                })
                .padding(.leading)
            }
            Text("Your score is \(self.score)")
                .padding(.top)
        }
    }
}

struct Grade1IntervalExercise_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
