//
//  ChordPlayer.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2020-11-10.
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

struct ChordPlayer {
    var midiPlayer: AVMIDIPlayer?
    var chord: Chord!
    
    init(chord: Chord) {
        self.setChord(chord: chord)
    }
    
    mutating func setChord(chord: Chord) {
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
        
        
        let sequence: [UInt8] = CommonMIDIHeaders.INTERVAL_MIDI_HEADER + CommonMIDIHeaders.INTERVAL_MIDI_TRACK_METADATA + chordEvents + CommonMIDIHeaders.END_OF_TRACK_BYTES
        let data = Data.init(sequence)
        
        guard let bankURL = Bundle.main.url(forResource: "FluidR3_GM", withExtension: "sf2") else {
            fatalError("soundbank file not found.")
        }
        do {
            self.midiPlayer = try AVMIDIPlayer.init(data: data, soundBankURL: bankURL)
            self.midiPlayer!.prepareToPlay()
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func playChord() {
        if !self.midiPlayer!.isPlaying {
            self.midiPlayer!.currentPosition = 0
            self.midiPlayer!.play({
                self.midiPlayer!.stop()
            })
        }
    }
}
