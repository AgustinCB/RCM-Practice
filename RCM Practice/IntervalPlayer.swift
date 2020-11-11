//
//  IntervalPlayer.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2020-10-26.
//

import AVFoundation
import Foundation

struct IntervalPlayer {
    var midiPlayer: AVMIDIPlayer?
    var root: UInt8!
    var interval: UInt8!
    
    init(root: UInt8, interval: UInt8) {
        self.setInterval(root: root, interval: interval)
    }
    
    mutating func setInterval(root: UInt8, interval: UInt8) {
        self.root = root
        self.interval = interval
        let intervalNote = root + interval
        let sequence: [UInt8] = CommonMIDIHeaders.INTERVAL_MIDI_HEADER + CommonMIDIHeaders.INTERVAL_MIDI_TRACK_METADATA + [
            0x00, 0x90, root, 0x60, // Play the root at beat 1.
            0x01, 0x80, root, 0x00, // Stop playing the root at beat 2.
            0x00, 0x90, intervalNote, 0x60, // Play the interval at beat 2.
            0x01, 0x80, intervalNote, 0x00, // Stop playing the interval at beat 3.
            0x01, 0x90, intervalNote, 0x60, // Play the interval at beat 4.
            0x01, 0x80, intervalNote, 0x00, // Stop playing the interval at beat 5.
            0x00, 0x90, root, 0x60, // Play the root at beat 5.
            0x01, 0x80, root, 0x00, // Stop playing the root at beat 6.
        ] + CommonMIDIHeaders.END_OF_TRACK_BYTES
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
    func playInterval() {
        if !self.midiPlayer!.isPlaying {
            self.midiPlayer!.currentPosition = 0
            self.midiPlayer!.play()
        }
    }
}
