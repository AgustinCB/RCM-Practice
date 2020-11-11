//
//  Grade1TriadExercise.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2020-11-10.
//

import SwiftUI

fileprivate struct Grade1TriadExerciseMessages{
    static let WELLCOME_MESSAGE = "Hey there! Guess the chord!"
    static let PLAY_CHORD = "Play Chord"
    static let PLAYING_CHORD = "Playing the Chord..."
    static let GUESS_MINOR = "Guess minor triad"
    static let GUESS_MAJOR = "Guess major triad"
    static let MAJOR_TRIAD = "Guessed Major Chord"
    static let MINOR_TRIAD = "Guessed Minor Chord"
    static let CORRECT_GUESS = "You guessed correctly! Hurray!"
    static let INCORRECT_GUESS = "You guessed wrongly! Looser!"
}

fileprivate func generateRandomTriad() -> Chord {
    let root = UInt8.random(in: 60...71)
    let quality = ChordQuality.allCases.randomElement()!
    let notes = [root, root + quality.rawValue, root + 7]
    return Chord.init(chordQuality: quality, chordNotes: notes)
}

struct Grade1TriadExercise: View {
    @State var score: Int = 0
    @State var message: String = Grade1TriadExerciseMessages.WELLCOME_MESSAGE
    @State var chordPlayer: ChordPlayer! = ChordPlayer.init(chord: generateRandomTriad())
    
    fileprivate func processGuess(quality: ChordQuality) {
        var result: String = ""
        if self.chordPlayer.chord.chordQuality == quality {
            self.score += 1
            result = Grade1TriadExerciseMessages.CORRECT_GUESS
        } else {
            result = Grade1TriadExerciseMessages.INCORRECT_GUESS
        }
        self.message = result
        self.chordPlayer.setChord(chord: generateRandomTriad())
    }
    
    var body: some View {
        VStack {
            Text("\(self.message)")
                .padding()
            Button(Grade1TriadExerciseMessages.PLAY_CHORD, action: {
                self.message = Grade1TriadExerciseMessages.PLAYING_CHORD
                self.chordPlayer.playChord()
            })
            .padding(.bottom)
            HStack {
                Button(Grade1TriadExerciseMessages.GUESS_MAJOR, action: {
                    self.message = Grade1TriadExerciseMessages.MAJOR_TRIAD
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        processGuess(quality: ChordQuality.Major)
                    }
                })
                .padding(.trailing)
                Button(Grade1TriadExerciseMessages.GUESS_MINOR, action: {
                    self.message = Grade1TriadExerciseMessages.MINOR_TRIAD;
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        processGuess(quality: ChordQuality.Minor)
                    }
                })
                .padding(.leading)
            }
            Text("Your score is \(self.score)")
                .padding(.top)
        }
    }
}

struct Grade1TriadExercise_Previews: PreviewProvider {
    static var previews: some View {
        Grade1TriadExercise()
    }
}
