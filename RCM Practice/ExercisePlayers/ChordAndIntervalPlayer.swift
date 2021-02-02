//
//  ChordAndIntervalPlayer.swift
//  RCM Practice
//

import Foundation

class ChordAndIntervalPlayer : ExercisePlayer {
    typealias G = UInt8
    
    var midiPlayer: MIDIPlayer! = MIDIPlayer()
    var chord: Chord!
    var interval: UInt8!
    
    required init() {
        self.randomReset()
    }
    
    func checkGuess(_ guess: G) -> Bool {
        return guess == interval
    }
    
    func guess(_ guessIndex: Int) -> G {
        return chord.chordNotes[guessIndex]
    }
    
    func randomReset() {
        let root = UInt8.random(in: 60...71)
        let quality = [ChordQuality.minor, ChordQuality.major].randomElement()!
        let notes = quality.createChordNotes(root: root)
        interval = notes.randomElement()!
        self.setChord(Chord.init(chordQuality: quality, chordNotes: notes, rootNote: root))
    }
    
    func play() {
        self.midiPlayer.play()
    }
    
    func setChord(_ chord: Chord) {
        self.chord = chord
        var chordEvents: [UInt8] = []
        for chord in self.chord.chordNotes {
            chordEvents += [
                0x00, 0x90, chord, 0x60, // Note on
                0x01, 0x80, chord, 0x00, // Note off
            ]
        }
        chordEvents += [
            0x01, 0x90, interval, 0x60, // Note on
            0x01, 0x80, interval, 0x00, // Note off
        ]
        
        self.midiPlayer.setSequence(chordEvents)
    }
}
