//
//  ChordPlayer.swift
//  RCM Practice
//

import AVFoundation
import Foundation

enum ChordQuality: UInt8, CaseIterable {
    case Major = 4
    case Minor = 3
}

struct Chord {
    let chordQuality: ChordQuality!
    let chordNotes: [UInt8]!
}

fileprivate func generateRandomTriad() -> Chord {
    let root = UInt8.random(in: 60...71)
    let quality = ChordQuality.allCases.randomElement()!
    let notes = [root, root + quality.rawValue, root + 7]
    return Chord.init(chordQuality: quality, chordNotes: notes)
}

struct ChordPlayer: ExercisePlayer {
    typealias G = ChordQuality
    
    var midiPlayer: MIDIPlayer! = MIDIPlayer()
    var chord: Chord!
    
    init() {
        self.randomReset()
    }
    
    func checkGuess(_ guess: G) -> Bool {
        self.chord.chordQuality == guess
    }
    
    static func firstGuess() -> G {
        ChordQuality.Minor
    }
    
    static func secondGuess() -> G {
        ChordQuality.Major
    }
    
    mutating func randomReset() {
        let root = UInt8.random(in: 60...71)
        let quality = ChordQuality.allCases.randomElement()!
        let notes = [root, root + quality.rawValue, root + 7]
        self.setChord(Chord.init(chordQuality: quality, chordNotes: notes))
    }
    func play() {
        print("PREV")
        self.midiPlayer.play()
    }
    
    fileprivate mutating func setChord(_ chord: Chord) {
        self.chord = chord
        var chordEvents: [UInt8] = []
        
        var chordOffEvents: [UInt8] = []
        var chordOnEvents: [UInt8] = []
        for (index, chord) in self.chord.chordNotes.enumerated() {
            chordEvents += [
                0x00, 0x90, chord, 0x60, // Note on
                0x01, 0x80, chord, 0x00, // Note off
            ]
            let chordTimeLapsus: UInt8 = index == 0 ? 0x01 : 0x00
            
            /*
             Expected sum of chordOnEvents and chordOffEvents
             0x01, 0x90, root, 0x60
             0x00, 0x90, third, 0x60
             0x00, 0x90, fifth, 0x60
             0x01, 0x80, root, 0x60
             0x00, 0x80, third, 0x60
             0x00, 0x80, fifth, 0x60
             
             Note that the first byte of every MIDI event is the ticks from the last event
             And not the ticks from the beginning of the sequence.
             */
            chordOnEvents += [
                chordTimeLapsus, 0x90, chord, 0x60, // Note on on the chord
            ]
            chordOffEvents += [
                chordTimeLapsus, 0x80, chord, 0x00 // Note off on the chord
            ]
        }
        chordEvents += chordOnEvents + chordOffEvents
        
        self.midiPlayer.setSequence(chordEvents)
    }
}
