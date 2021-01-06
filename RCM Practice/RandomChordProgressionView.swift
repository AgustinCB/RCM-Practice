//
//  RamdonChordProgressionView.swift
//  RCM Practice
//

import SwiftUI

struct RandomChordProgressionView: View {
    static let WELCOME_MESSAGE = "Guess chord progression"
    static let PLAY_MESSAGE = "Play chord progression"
    static let PLAYING_MESSAGE = "Playing chord progression"
    @State var player = RandomChordProgressionPlayer.init()
    @State var message: String = RandomChordProgressionView.WELCOME_MESSAGE
    @State private var firstChord = 0
    @State private var secondChord = 0
    @State private var thirdChord = 0
    @State private var fourthChord = 0
    
    fileprivate func processGuess(progression: RandomChordProgressionPlayer.G) {
        var result: String = ""
        if self.player.checkGuess(progression)   {
            result = GeneralMessages.CORRECT_GUESS
        } else {
            result = GeneralMessages.INCORRECT_GUESS
        }
        self.message = result
        self.player.randomReset()
    }
    
    var body: some View {
        List {
            Section(header: Button(RandomChordProgressionView.PLAY_MESSAGE, action: {
                self.message = RandomChordProgressionView.PLAYING_MESSAGE
                self.player.play()
            }), footer: Text(self.message)) {
                VStack {
                    Picker("First Chord", selection: $firstChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Picker("Second Chord", selection: $secondChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Picker("Third Chord", selection: $thirdChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Picker("Fourth Chord", selection: $fourthChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Button("Guess", action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            let guess: [AbstractChord] = [player.chordOptions[firstChord], player.chordOptions[secondChord], player.chordOptions[thirdChord], player.chordOptions[fourthChord]]
                            self.processGuess(progression: guess)
                        }
                    })
                }
            }
        }.navigationBarTitle(RandomChordProgressionView.WELCOME_MESSAGE)
    }
}

struct RandomOrCadential64ChordProgressionView: View {
    static let WELCOME_MESSAGE = "Guess chord progression"
    static let PLAY_MESSAGE = "Play chord progression"
    static let PLAYING_MESSAGE = "Playing chord progression"
    @State var player = RandomOrCadential64ChordProgressionPlayer.init()
    @State var message: String = RandomChordProgressionView.WELCOME_MESSAGE
    @State private var firstChord = 0
    @State private var secondChord = 0
    @State private var thirdChord = 0
    @State private var fourthChord = 0
    @State private var fifthChord = 0
    
    fileprivate func processGuess(progression: RandomChordProgressionPlayer.G) {
        var result: String = ""
        if self.player.checkGuess(progression) {
            result = GeneralMessages.CORRECT_GUESS
        } else {
            result = GeneralMessages.INCORRECT_GUESS
        }
        self.message = result
        self.player.randomReset()
    }
    
    var body: some View {
        List {
            Section(header: Button(RandomChordProgressionView.PLAY_MESSAGE, action: {
                self.message = RandomChordProgressionView.PLAYING_MESSAGE
                self.player.play()
            }), footer: Text(self.message)) {
                VStack {
                    Picker("First Chord", selection: $firstChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Picker("Second Chord", selection: $secondChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Picker("Third Chord", selection: $thirdChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Picker("Fourth Chord", selection: $fourthChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Picker("Fifth Chord", selection: $fifthChord) {
                        ForEach(0 ..< self.player.chordOptions.count) {
                            Text(self.player.chordOptions[$0].note.toString() + " " + self.player.chordOptions[$0].chordQuality.rawValue)
                        }
                    }
                    Button("Guess", action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            let guess: [AbstractChord] = [player.chordOptions[firstChord], player.chordOptions[secondChord], player.chordOptions[thirdChord], player.chordOptions[fourthChord], player.chordOptions[fifthChord]]
                            self.processGuess(progression: guess)
                        }
                    })
                    Button("Guess Cadential 6 4", action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            let guess: [AbstractChord] = RandomOrCadential64ChordProgressionPlayer.CADENTIAL_CHORD_PROGRESSION
                            self.processGuess(progression: guess)
                        }
                    })
                }
            }
        }.navigationBarTitle(RandomChordProgressionView.WELCOME_MESSAGE)
    }
}
