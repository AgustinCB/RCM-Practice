//
//  IntervalPlayer.swift
//  RCM Practice
//

import AVFoundation
import Foundation

enum Note: UInt8, CaseIterable {
    case MajorThird = 4
    case MinorThird = 3
}

struct IntervalPlayer: ExercisePlayer {
    typealias G = Note
    
    var midiPlayer: MIDIPlayer! = MIDIPlayer()
    var root: UInt8!
    var interval: UInt8!
    
    init() {
        self.randomReset()
    }
    
    func checkGuess(_ guess: G) -> Bool {
        interval == guess.rawValue
    }
    
    mutating func randomReset() {
        let root = UInt8.random(in: 60...71)
        let interval = Note.allCases.randomElement()!.rawValue
        self.setInterval(root: root, interval: interval)
    }
    
    func play() {
        self.midiPlayer.play()
    }
    
    static func firstGuess() -> G {
        Note.MinorThird
    }
    
    static func secondGuess() -> G {
        Note.MajorThird
    }
    
    mutating func setInterval(root: UInt8, interval: UInt8) {
        self.root = root
        self.interval = interval
        let intervalNote = root + interval
        let sequence: [UInt8] = [
            0x00, 0x90, root, 0x60, // Play the root at beat 1.
            0x01, 0x80, root, 0x00, // Stop playing the root at beat 2.
            0x00, 0x90, intervalNote, 0x60, // Play the interval at beat 2.
            0x01, 0x80, intervalNote, 0x00, // Stop playing the interval at beat 3.
            0x01, 0x90, intervalNote, 0x60, // Play the interval at beat 4.
            0x01, 0x80, intervalNote, 0x00, // Stop playing the interval at beat 5.
            0x00, 0x90, root, 0x60, // Play the root at beat 5.
            0x01, 0x80, root, 0x00, // Stop playing the root at beat 6.
        ]
        self.midiPlayer.setSequence(sequence)
    }
}
