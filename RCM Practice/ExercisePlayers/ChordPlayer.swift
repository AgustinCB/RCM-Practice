//
//  ChordPlayer.swift
//  RCM Practice
//

import AVFoundation
import Foundation

enum ChordQuality: String, CaseIterable {
    case major
    case minor
    case major4Notes
    case minor4Notes
    case dominantSeventh
    case diminishedSeventh
    case augmentedTriad
    case majormajor7th
    case minorminor7th
    case fourSix
}

extension ChordQuality {
    func createChordNotes(root: UInt8) -> [UInt8] {
        var notes: [UInt8]
        switch self {
        case .major:
            notes = [root, root + Note.MajorThird.rawValue, root + Note.PerfectFifth.rawValue]
            break
        case .minor:
            notes = [root, root + Note.MinorThird.rawValue, root + Note.PerfectFifth.rawValue]
            break
        case .major4Notes:
            notes = [root, root + Note.MajorThird.rawValue, root + Note.PerfectFifth.rawValue, root + Note.MajorSeventh.rawValue]
            break
        case .minor4Notes:
            notes = [root, root + Note.MinorThird.rawValue, root + Note.PerfectFifth.rawValue, root + Note.MinorSeventh.rawValue]
            break
        case .dominantSeventh:
            notes = [root, root + Note.MajorThird.rawValue, root + Note.PerfectFifth.rawValue, root + Note.MinorSeventh.rawValue]
            break
        case .diminishedSeventh:
            notes = [root, root + Note.MinorThird.rawValue, root + Note.Tritone.rawValue, root + Note.MajorSixth.rawValue]
            break
        case .augmentedTriad:
            notes = [root, root + Note.MajorThird.rawValue, root + Note.Tritone.rawValue]
            break
        case .majormajor7th:
            notes = [root, root + Note.MajorThird.rawValue, root + Note.MajorSeventh.rawValue]
            break
        case .minorminor7th:
            notes = [root, root + Note.MinorThird.rawValue, root + Note.MinorSeventh.rawValue]
            break
        case .fourSix:
            notes = [root, root + Note.PerfectForth.rawValue, root + Note.MajorSixth.rawValue]
            break
        }
        return notes
    }
}

struct Chord {
    let chordQuality: ChordQuality
    let chordNotes: [UInt8]
    let chordInversion: Inversion
    let rootNote: UInt8
    
    init(chordQuality: ChordQuality, chordNotes: [UInt8], rootNote: UInt8) {
        self.chordInversion = Inversion.first
        self.chordNotes = chordNotes.sorted()
        self.chordQuality = chordQuality
        self.rootNote = rootNote
    }
    
    init(chordQuality: ChordQuality, chordNotes: [UInt8], chordInversion: Inversion, rootNote: UInt8) {
        self.chordInversion = chordInversion
        self.chordNotes = chordNotes.sorted()
        self.chordQuality = chordQuality
        self.rootNote = rootNote
    }
    
    func invert(inversion: Inversion) -> Chord {
        var chordNotes: [UInt8] = []
        var rootNote = self.rootNote
        switch (inversion, self.chordInversion) {
        case (.first, .first), (.second, .second), (.third, .third):
            chordNotes = self.chordNotes
            break
        case (.second, .third):
            rootNote -= 12
        case (.third, .first), (.first, .second):
            chordNotes = [self.chordNotes.last! - 12] + self.chordNotes[0...self.chordNotes.count-2]
            break
        case (.first, .third):
            rootNote += 12
        case (.second, .first), (.third, .second):
            chordNotes = self.chordNotes[1...self.chordNotes.count-1] + [self.chordNotes.first! + 12]
            break
        }
        return Chord.init(chordQuality: chordQuality, chordNotes: chordNotes, chordInversion: inversion, rootNote: rootNote)
    }
}

class ChordPlayer: ExercisePlayer {
    typealias G = ChordQuality
    
    var chordQualityOptions: [ChordQuality]
    var chordInversionOptions: [Inversion]
    var midiPlayer: MIDIPlayer! = MIDIPlayer()
    var chord: Chord!
    
    required convenience init() {
        self.init([ChordQuality.minor, ChordQuality.major], [.first])
    }
    
    init(_ chordQualityOptions: [ChordQuality], _ chordInversionOptions: [Inversion]) {
        self.chordQualityOptions = chordQualityOptions
        self.chordInversionOptions = chordInversionOptions
        self.randomReset()
    }
    
    func checkGuess(_ guess: G) -> Bool {
        self.chord.chordQuality == guess
    }
    
    func guess(_ guessIndex: Int) -> ChordQuality {
        return chordQualityOptions[guessIndex]
    }
    
    func randomReset() {
        let root = UInt8.random(in: 60...71)
        let inversion = chordInversionOptions.randomElement()!
        let quality = chordQualityOptions.randomElement()!
        let initialChord = Chord.init(chordQuality: quality, chordNotes: quality.createChordNotes(root: root), rootNote: root)
        self.setChord(initialChord.invert(inversion: inversion))
    }

    func play() {
        self.midiPlayer.play()
    }
    
    func setChord(_ chord: Chord) {
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

class PentatonicAndChordPlayer: ChordPlayer {
    override func setChord(_ chord: Chord) {
        self.chord = chord
        
        var pentatonicSequence: [UInt8] = []
        if self.chord.chordQuality == .major {
            pentatonicSequence = [
                0x00, 0x90, chord.rootNote, 0x60,
                0x01, 0x80, chord.rootNote, 0x00,
                0x00, 0x90, chord.rootNote + Note.MajorSecond.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.MajorSecond.rawValue, 0x00,
                0x00, 0x90, chord.rootNote + Note.MajorThird.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.MajorThird.rawValue, 0x00,
                0x00, 0x90, chord.rootNote + Note.PerfectForth.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.PerfectForth.rawValue, 0x00,
                0x00, 0x90, chord.rootNote + Note.PerfectFifth.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.PerfectFifth.rawValue, 0x00,
            ]
        } else {
            pentatonicSequence = [
                0x00, 0x90, chord.rootNote, 0x60,
                0x01, 0x80, chord.rootNote, 0x00,
                0x00, 0x90, chord.rootNote + Note.MajorSecond.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.MajorSecond.rawValue, 0x00,
                0x00, 0x90, chord.rootNote + Note.MinorThird.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.MinorThird.rawValue, 0x00,
                0x00, 0x90, chord.rootNote + Note.PerfectForth.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.PerfectForth.rawValue, 0x00,
                0x00, 0x90, chord.rootNote + Note.PerfectFifth.rawValue, 0x60,
                0x01, 0x80, chord.rootNote + Note.PerfectFifth.rawValue, 0x00,
            ]
        }
        
        var chordOffEvents: [UInt8] = []
        var chordOnEvents: [UInt8] = []
        for (index, chord) in self.chord.chordNotes.enumerated() {
            let chordTimeLapsus: UInt8 = index == 0 ? 0x01 : 0x00
            
            chordOnEvents += [
                chordTimeLapsus, 0x90, chord, 0x60, // Note on on the chord
            ]
            chordOffEvents += [
                chordTimeLapsus, 0x80, chord, 0x00 // Note off on the chord
            ]
        }
        let chordEvents = pentatonicSequence + chordOnEvents + chordOffEvents
        
        self.midiPlayer.setSequence(chordEvents)
    }
}

class ThreeQualitiesChordPlayer: BlockOnlyChordPlayer {
    required convenience init() {
        self.init([ChordQuality.minor, ChordQuality.major, ChordQuality.dominantSeventh], [.first])
    }
}

class FourQualitiesChordPlayer: BlockOnlyChordPlayer {
    required convenience init() {
        self.init([ChordQuality.minor, ChordQuality.major, ChordQuality.dominantSeventh, ChordQuality.diminishedSeventh], [.first])
    }
}

class FiveQualitiesChordPlayer: BlockOnlyChordPlayer {
    required convenience init() {
        self.init([ChordQuality.minor, ChordQuality.major, ChordQuality.dominantSeventh, ChordQuality.diminishedSeventh, ChordQuality.augmentedTriad], [.first])
    }
}

class SixQualitiesChordPlayer: BlockOnlyChordPlayer {
    required convenience init() {
        self.init([ChordQuality.minor4Notes, ChordQuality.major4Notes, ChordQuality.dominantSeventh, ChordQuality.diminishedSeventh, ChordQuality.augmentedTriad], [.first, .second])
    }
}

class EightQualitiesChordPlayer: BlockOnlyChordPlayer {
    required convenience init() {
        self.init([ChordQuality.minor4Notes, ChordQuality.major4Notes, ChordQuality.dominantSeventh, ChordQuality.diminishedSeventh, ChordQuality.augmentedTriad, .majormajor7th, .minorminor7th], [.first, .second])
    }
}
