//
//  RamdonChordProgressionView.swift
//  RCM Practice
//

import SwiftUI

struct ChordPicker: View {
    var chordOptions: [AbstractChord]
    var message: String
    var variable: Binding<Int>
    
    var body: some View {
        VStack {
            Text(message)
            Picker(message, selection: variable) {
                ForEach(0 ..< chordOptions.count) {
                    Text(chordOptions[$0].note.toString() + " " + chordOptions[$0].chordQuality.toString())
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: .infinity, alignment: .center)
        }.padding(10)
    }
}

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
            Section(header: createHeader(self.message)) {
                CenteredContent {
                    Button(RandomChordProgressionView.PLAY_MESSAGE, action: {
                        self.message = RandomChordProgressionView.PLAYING_MESSAGE
                        self.player.play()
                    })
                    .buttonStyle(ActionButtonStyle())
                }
                ChordPicker(chordOptions: self.player.chordOptions, message: "First Chord", variable: $firstChord)
                ChordPicker(chordOptions: self.player.chordOptions, message: "Second Chord", variable: $secondChord)
                ChordPicker(chordOptions: self.player.chordOptions, message: "Third Chord", variable: $thirdChord)
                ChordPicker(chordOptions: self.player.chordOptions, message: "Fourth Chord", variable: $fourthChord)
                CenteredContent {
                    Button("Guess", action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            let guess: [AbstractChord] = [player.chordOptions[firstChord], player.chordOptions[secondChord], player.chordOptions[thirdChord], player.chordOptions[fourthChord]]
                            self.processGuess(progression: guess)
                        }
                    })
                    .buttonStyle(ActionButtonStyle(color: .blue))
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(RandomChordProgressionView.WELCOME_MESSAGE)
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
            Section(header: createHeader(self.message)) {
                CenteredContent {
                    Button(RandomChordProgressionView.PLAY_MESSAGE, action: {
                        self.message = RandomChordProgressionView.PLAYING_MESSAGE
                        self.player.play()
                    })
                    .buttonStyle(ActionButtonStyle())
                }
                ChordPicker(chordOptions: self.player.chordOptions, message: "First Chord", variable: $firstChord)
                ChordPicker(chordOptions: self.player.chordOptions, message: "Second Chord", variable: $secondChord)
                ChordPicker(chordOptions: self.player.chordOptions, message: "Third Chord", variable: $thirdChord)
                ChordPicker(chordOptions: self.player.chordOptions, message: "Fourth Chord", variable: $fourthChord)
                ChordPicker(chordOptions: self.player.chordOptions, message: "Fifth Chord", variable: $fifthChord)
                HStack {
                    Button("Guess", action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            let guess: [AbstractChord] = [player.chordOptions[firstChord], player.chordOptions[secondChord], player.chordOptions[thirdChord], player.chordOptions[fourthChord], player.chordOptions[fifthChord]]
                            self.processGuess(progression: guess)
                        }
                    })
                    .buttonStyle(ActionButtonStyle(color: Color.blue))
                    Button("Guess Cadential 6 4", action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            let guess: [AbstractChord] = RandomOrCadential64ChordProgressionPlayer.CADENTIAL_CHORD_PROGRESSION
                            self.processGuess(progression: guess)
                        }
                    })
                    .buttonStyle(ActionButtonStyle(color: Color.blue))
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(RandomChordProgressionView.WELCOME_MESSAGE)
    }
}
