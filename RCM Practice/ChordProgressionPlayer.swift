//
//  ChordProgressionPlayer.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2020-12-08.
//

import Foundation

enum Inversion: UInt8, CaseIterable {
    case first = 0
    case second = 1
    case third = 2
}

extension Inversion {
    func add(_ to: Inversion) -> Inversion {
        Inversion.init(rawValue: (self.rawValue + to.rawValue) % UInt8(Inversion.allCases.count))!
    }
}

struct AbstractChord: Equatable, Hashable {
    static func == (lhs: AbstractChord, rhs: AbstractChord) -> Bool {
        return lhs.note == rhs.note && rhs.chordQuality == lhs.chordQuality
    }
    let note: Note
    let chordQuality: ChordQuality
}

extension AbstractChord: Identifiable {
    typealias ID = String
    
    var id: Self.ID {
        self.note.toString() + self.chordQuality.rawValue
    }
}

struct ChordTransition {
    let from: AbstractChord
    let to: AbstractChord
}

extension ChordTransition {
    func performTransition(chordFrom: Chord) -> Chord {
        var newRootNote: UInt8
        if (self.from.note.rawValue > self.to.note.rawValue) {
            newRootNote = chordFrom.rootNote - (self.from.note.rawValue - self.to.note.rawValue)
        } else {
            newRootNote = chordFrom.rootNote + (self.to.note.rawValue - self.from.note.rawValue)
        }
        let firstInversionChordNotes = self.to.chordQuality.createChordNotes(root: newRootNote)
        var inversion: Inversion
        var toValue: UInt8 = self.to.note.rawValue
        if self.to.note.rawValue < self.from.note.rawValue {
            toValue += 12
        }
        switch Note.init(rawValue: toValue - self.from.note.rawValue)! {
        case Note.Root, Note.Octave, Note.MinorSecond, Note.MajorSecond, Note.MinorSeventh, Note.MajorSeventh:
            inversion = Inversion.first.add(chordFrom.chordInversion)
            break
        case Note.MinorThird, Note.MajorThird, Note.PerfectForth:
            inversion = Inversion.second.add(chordFrom.chordInversion)
            break
        default:
            inversion = Inversion.third.add(chordFrom.chordInversion)
        }
        let originalChord = Chord.init(chordQuality: self.to.chordQuality, chordNotes: firstInversionChordNotes, chordInversion: .first, rootNote: newRootNote)
        return originalChord.invert(inversion: inversion)
    }
}

enum ChordProgression {
    case IVI
    case IIVI
    case ivi
    case iivi
    case IIVV
    case iivV
    case IIVVI
    case iivvi
    case IIVVvi
    case iivVVI
    case IviIVV
    case iVIivV
    case IviIVI
    case iVIivi
    case cadential46
}

extension ChordProgression {
    func getInitialChordQuality() -> ChordQuality {
        switch self {
        case .IIVI, .IVI, .IIVV, .IIVVI, .IIVVvi, .IviIVV, .IviIVI, .cadential46:
            return .major
        case .ivi, .iivi, .iivV, .iivvi, .iivVVI, .iVIivV, .iVIivi:
            return .minor
        }
    }
    func getTransitions() -> [ChordTransition] {
        switch self {
        case .IVI:
            return [ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major)), ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .major), to: AbstractChord.init(note: .Root, chordQuality: .major))]
        case .IIVI:
            return [ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .PerfectForth, chordQuality: .major)), ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .major), to: AbstractChord.init(note: .Root, chordQuality: .major))]
        case .ivi:
            return [ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .minor), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .minor)), ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .minor), to: AbstractChord.init(note: .Root, chordQuality: .minor))]
        case .iivi:
            return [ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .minor), to: AbstractChord.init(note: .PerfectForth, chordQuality: .minor)), ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .minor), to: AbstractChord.init(note: .Root, chordQuality: .minor))]
        case .IIVV:
            return [ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .PerfectForth, chordQuality: .major)), ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .major), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major))]
        case .iivV:
            return [ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .minor), to: AbstractChord.init(note: .PerfectForth, chordQuality: .minor)), ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .minor), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major))]
        case .IIVVI:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .PerfectForth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .major), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .major), to: AbstractChord.init(note: .Root, chordQuality: .major)),
            ]
        case .iivvi:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .minor), to: AbstractChord.init(note: .PerfectForth, chordQuality: .minor)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .minor), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .minor)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .minor), to: AbstractChord.init(note: .Root, chordQuality: .minor)),
            ]
        case .IIVVvi:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .PerfectForth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .major), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .major), to: AbstractChord.init(note: .MajorSixth, chordQuality: .minor)),
            ]
        case .iivVVI:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .minor), to: AbstractChord.init(note: .PerfectForth, chordQuality: .minor)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .minor), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .major), to: AbstractChord.init(note: .MinorSixth, chordQuality: .major)),
            ]
        case .IviIVV:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .MajorSixth, chordQuality: .minor)),
                ChordTransition.init(from: AbstractChord.init(note: .MajorSixth, chordQuality: .minor), to: AbstractChord.init(note: .PerfectForth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .major), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major)),
            ]
        case .iVIivV:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .minor), to: AbstractChord.init(note: .MinorSixth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .MinorSixth, chordQuality: .major), to: AbstractChord.init(note: .PerfectForth, chordQuality: .minor)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .minor), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major)),
            ]
        case .IviIVI:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .MajorSixth, chordQuality: .minor)),
                ChordTransition.init(from: AbstractChord.init(note: .MajorSixth, chordQuality: .minor), to: AbstractChord.init(note: .PerfectForth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .major), to: AbstractChord.init(note: .Root, chordQuality: .major)),
            ]
        case .iVIivi:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .minor), to: AbstractChord.init(note: .MinorSixth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .MinorSixth, chordQuality: .major), to: AbstractChord.init(note: .PerfectForth, chordQuality: .minor)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .minor), to: AbstractChord.init(note: .Root, chordQuality: .minor)),
            ]
        case .cadential46:
            return [
                ChordTransition.init(from: AbstractChord.init(note: .Root, chordQuality: .major), to: AbstractChord.init(note: .PerfectForth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectForth, chordQuality: .major), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .fourSix)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .fourSix), to: AbstractChord.init(note: .PerfectFifth, chordQuality: .major)),
                ChordTransition.init(from: AbstractChord.init(note: .PerfectFifth, chordQuality: .major), to: AbstractChord.init(note: .Root, chordQuality: .major))
            ]
        }
    }
    func getProgressionChords(initialChord: Chord) -> [Chord] {
        var chords = [initialChord]
        for transition in self.getTransitions() {
            chords.append(transition.performTransition(chordFrom: chords.last!))
        }
        return chords
    }
}

class ChordProgressionPlayer: ExercisePlayer {
    typealias G = ChordProgression
    
    var chordProgressionOptions: [ChordProgression]
    var midiPlayer: MIDIPlayer! = MIDIPlayer()
    var chordProgression: ChordProgression!
    
    required convenience init() {
        self.init([ChordProgression.IIVI, ChordProgression.IVI])
    }
    
    init(_ chordProgressionOptions: [ChordProgression]) {
        self.chordProgressionOptions = chordProgressionOptions
        self.randomReset()
    }
    
    func checkGuess(_ guess: G) -> Bool {
        self.chordProgression == guess
    }
    
    func guess(_ guessIndex: Int) -> G {
        return chordProgressionOptions[guessIndex]
    }
    
    func randomReset() {
        let root = UInt8.random(in: 60...71)
        chordProgression = chordProgressionOptions.randomElement()!
        let quality = chordProgression.getInitialChordQuality()
        self.setChord(Chord.init(chordQuality: quality, chordNotes: quality.createChordNotes(root: root), rootNote: root))
    }

    func play() {
        self.midiPlayer.play()
    }
    
    func setChord(_ chord: Chord) {
        var chordEvents: [UInt8] = []
        
        for chord in chordProgression.getProgressionChords(initialChord: chord) {
            var chordOffEvents: [UInt8] = []
            var chordOnEvents: [UInt8] = []
            for (index, note) in chord.chordNotes.enumerated() {
                let chordTimeLapsus: UInt8 = index == 0 ? 0x02 : 0x00
                
                /*
                 Expected sum of chordOnEvents and chordOffEvents
                 0x00, 0x90, root, 0x60
                 0x00, 0x90, third, 0x60
                 0x00, 0x90, fifth, 0x60
                 0x02, 0x80, root, 0x60
                 0x00, 0x80, third, 0x60
                 0x00, 0x80, fifth, 0x60
                 
                 Note that the first byte of every MIDI event is the ticks from the last event
                 And not the ticks from the beginning of the sequence.
                 */
                chordOnEvents += [
                    0x00, 0x90, note, 0x60, // Note on on the chord
                ]
                chordOffEvents += [
                    chordTimeLapsus, 0x80, note, 0x00 // Note off on the chord
                ]
            }
            chordEvents += chordOnEvents + [
                0x00, 0x90, chord.chordNotes[0] - 12, 0x60,
            ] + chordOffEvents + [
                0x00, 0x80, chord.chordNotes[0] - 12, 0x60,
            ]
        }
        
        self.midiPlayer.setSequence(chordEvents)
    }
}

class FourOptionsChordProgressionPlayer: ChordProgressionPlayer {
    required convenience init() {
        self.init([.IIVI, .IVI, .ivi, .iivi])
    }
}

class SixOptionsChordProgressionPlayer: ChordProgressionPlayer {
    required convenience init() {
        self.init([.IIVI, .IVI, .ivi, .iivi, .IIVV, .iivV])
    }
}

class EightOptionsChordProgressionPlayer: ChordProgressionPlayer {
    required convenience init() {
        self.init([.IIVVI, .iivvi, .IIVVvi, .iivVVI, .IviIVV, .iVIivV, .IviIVI, .iVIivi])
    }
}
