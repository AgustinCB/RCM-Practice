//
//  BlockOnlyChordPlayer.swift
//  RCM Practice
//

import Foundation

class BlockOnlyChordPlayer : ChordPlayer {
    override func setChord(_ chord: Chord) {
        self.chord = chord
        
        var chordOffEvents: [UInt8] = []
        var chordOnEvents: [UInt8] = []
        for (index, chord) in self.chord.chordNotes.enumerated() {
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
        let chordEvents = chordOnEvents + chordOffEvents
        
        self.midiPlayer.setSequence(chordEvents)
    }
}
