//
//  MIDIPlayer.swift
//  RCM Practice
//

import AVFoundation
import Foundation

struct MIDIPlayer {
    var midiPlayer: AVMIDIPlayer?
    
    mutating func setSequence(_ noteEvents: [UInt8]) {
        let sequence: [UInt8] = CommonMIDIHeaders.INTERVAL_MIDI_HEADER + CommonMIDIHeaders.getIntervalMidiTrackMetatada(UInt32(noteEvents.count)) + noteEvents + CommonMIDIHeaders.END_OF_TRACK_BYTES
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

    func play() {
        if !self.midiPlayer!.isPlaying {
            self.midiPlayer!.currentPosition = 0
            self.midiPlayer!.play({
                self.midiPlayer!.stop()
            })
        }
    }
}
