//
//  CommonMIDIHeaders.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2020-11-10.
//

import Foundation

struct CommonMIDIHeaders {
    static let INTERVAL_MIDI_HEADER: [UInt8] = [
        0x4D, 0x54, 0x68, 0x64, // MIDI header: MThd
        0x00, 0x00, 0x00, 0x06, // MIDI header length: 6 bytes
        0x00, 0x00, // Single channel
        0x00, 0x01, // Number of channels
        0x00, 0x01, // Number of ticks per beat: 1 tick per beat
        0x4D, 0x54, 0x72, 0x6b, // Track header: MThd
    ]

    static let INTERVAL_MIDI_TRACK_METADATA: [UInt8] = [
        0x00, 0x00, 0x00, 0x3A, // Track length: 4 bytes * 8 events + 4 bytes for end of header + 22 for the headers = 58
        0x00, 0xFF, 0x58, 0x04, // Specify time signature, and clarify that the next four bytes will contain that information
        0x04, 0x04, 0x18, 0x08, // Time signature is 4/4, and 0x18 MIDI clocks in a metronome clock
        0x00, 0xFF, 0x51, 0x03, // Specify the tempo of the track.
        0x08, 0x7a, 0x23, // 1,000,000 microseconds per quarter note. Because it is in 4/4, this means 60 bpm.
        0x00, 0xc0, 0x01, // Set MIDI instrument to 79 (Flute)
        0x00, 0xb0, 0x07, 0x20, // Main volume
    ]

    static let END_OF_TRACK_BYTES: [UInt8] = [0x00,0xff,0x2f,0x00]
}
