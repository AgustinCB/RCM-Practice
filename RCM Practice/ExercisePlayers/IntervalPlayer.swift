//
//  IntervalPlayer.swift
//  RCM Practice
//

import AVFoundation
import Foundation

enum Note: UInt8, CaseIterable {
    case Root = 0
    case MinorSecond = 1
    case MajorSecond = 2
    case MinorThird = 3
    case MajorThird = 4
    case PerfectForth = 5
    case Tritone = 6
    case PerfectFifth = 7
    case MinorSixth = 8
    case MajorSixth = 9
    case MinorSeventh = 10
    case MajorSeventh = 11
    case Octave = 12
    case MinorNineth = 13
    case MajorNineth = 14
}

enum ExercisePlayerType : UInt8 {
    case intervalMelodicAscendingAndDescending = 0
    case intervalMelodicAndHarmonic = 1
    case intervalMelodicOrHarmonic = 2
    case chord = 3
    case chordBlockOnly = 4
    case chordWithPentatonic = 5
}

extension ExercisePlayerType {
    func getIntervalPlayer(notes: [Note]) -> IntervalPlayer {
        switch self {
        case .intervalMelodicAscendingAndDescending:
            return IntervalPlayer.init(possibleNotes: notes)
        case .intervalMelodicAndHarmonic:
            return IntervalMelodicAndHarmonicPlayer.init(possibleNotes: notes)
        case .intervalMelodicOrHarmonic:
            return IntervalMelodicOrHarmonicPlayer.init(possibleNotes: notes)
        default:
            fatalError("You cannot do this!")
        }
    }
    
    func getChordPlayer(chords: [ChordQuality]) -> ChordPlayer {
        switch self {
        case .chord:
            return ChordPlayer.init(chords, [Inversion.first])
        case .chordBlockOnly:
            return BlockOnlyChordPlayer.init(chords, [Inversion.first])
        case .chordWithPentatonic:
            return PentatonicAndChordPlayer.init(chords, [Inversion.first])
        default:
            fatalError("You cannot do this either!")
        }
    }
    
    func getMessages(notes: [Note], exerciseName: String) -> DynamicMessages {
        DynamicMessages.init(notes: notes, name: exerciseName)
    }
    
    func getMessages(qualities: [ChordQuality], exerciseName: String) -> DynamicMessages {
        DynamicMessages.init(qualities: qualities, name: exerciseName)
    }

    func getExercise(_ notes: [Note], _ exerciseName: String) -> ExerciseView<DynamicMessages, IntervalPlayer> {
        return ExerciseView.init(messages: self.getMessages(notes: notes, exerciseName: exerciseName), player: self.getIntervalPlayer(notes: notes))
    }
    
    func getExercise(_ qualities: [ChordQuality], _ exerciseName: String) -> ExerciseView<DynamicMessages, ChordPlayer> {
        return ExerciseView.init(messages: self.getMessages(qualities: qualities, exerciseName: exerciseName), player: self.getChordPlayer(chords: qualities))
    }
    
    func isChordPlayer() -> Bool {
        switch self {
        case .chord, .chordWithPentatonic, .chordBlockOnly:
            return true
        default:
            return false
        }
    }
}

extension Note {
    func toString() -> String {
        switch self {
        case .Root:
            return "Root"
        case .MinorSecond, .MajorSecond:
            return "Second"
        case .MinorThird, .MajorThird:
            return "Third"
        case .PerfectForth:
            return "Forth"
        case .Tritone:
            return "Tritone"
        case .PerfectFifth:
            return "Fifth"
        case .MinorSixth, .MajorSixth:
            return "Sixth"
        case .MinorSeventh, .MajorSeventh:
            return "Seventh"
        case .Octave:
            return "Octave"
        case .MajorNineth, .MinorNineth:
            return "Nineth"
        }
    }
    
    func toQualifiedString() -> String{
        switch self {
        case .Root:
            return "Root"
        case .MinorSecond:
            return "Minor Second"
        case .MajorSecond:
            return "Major Second"
        case .MinorThird:
            return "Minor Third"
        case .MajorThird:
            return "Major Third"
        case .PerfectForth:
            return "Forth"
        case .Tritone:
            return "Tritone"
        case .PerfectFifth:
            return "Fifth"
        case .MinorSixth:
            return "Minor Sixth"
        case .MajorSixth:
            return "Major Sixth"
        case .MinorSeventh:
            return "Minor Seventh"
        case .MajorSeventh:
            return "Major Seventh"
        case .Octave:
            return "Octave"
        case .MajorNineth:
            return "Major Nineth"
        case .MinorNineth:
            return "Minor Nineth"
        }
    }
}

enum IntervalPlaying: CaseIterable {
    case harmonic
    case melodic
}

enum Direction: CaseIterable {
    case ascending
    case descending
}

class IntervalPlayer: ExercisePlayer {
    typealias G = Note

    var possibleNotes: [Note] = []
    var midiPlayer: MIDIPlayer! = MIDIPlayer()
    var root: UInt8!
    var interval: UInt8!

    init(possibleNotes: [Note]) {
        self.possibleNotes = possibleNotes
        self.randomReset()
    }
    
    required convenience init() {
        self.init(possibleNotes: Note.allCases)
    }
    
    func checkGuess(_ guess: G) -> Bool {
        interval == guess.rawValue
    }
    
    func randomReset() {
        let root = UInt8.random(in: 60...71)
        let interval = possibleNotes.randomElement()!.rawValue
        self.setInterval(root: root, interval: interval)
    }
    
    func play() {
        self.midiPlayer.play()
    }
    
    func guess(_ guessIndex: Int) -> Note {
        return possibleNotes[guessIndex]
    }
    
    func setInterval(root: UInt8, interval: UInt8) {
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

class IntervalMelodicAndHarmonicPlayer : IntervalPlayer {
    var direction: Direction!
    
    override func randomReset() {
        direction = Direction.allCases.randomElement()!
        super.randomReset()
    }
    
    override func setInterval(root: UInt8, interval: UInt8) {
        self.root = root
        self.interval = interval
        let intervalNote = root + interval
        let rootNoteEvents = [
            0x00, 0x90, root, 0x60, // Play the root.
            0x01, 0x80, root, 0x00, // Stop playing the root.
        ]
        let intervalNoteEvents = [
            0x00, 0x90, intervalNote, 0x60, // Play the interval.
            0x01, 0x80, intervalNote, 0x00, // Stop playing the interval.
        ]
        let blockIntervalEvents = [
            0x01, 0x90, root, 0x60, // Play the root.
            0x00, 0x90, intervalNote, 0x60, // Play the interval.
            0x01, 0x80, root, 0x00, // Stop playing the root.
            0x00, 0x80, intervalNote, 0x00, // Stop playing the interval.
        ]
        let sequence: [UInt8] = (direction! == .ascending ?
            rootNoteEvents + intervalNoteEvents :
            intervalNoteEvents + rootNoteEvents) + blockIntervalEvents
        
        self.midiPlayer.setSequence(sequence)
    }
}

class IntervalMelodicOrHarmonicPlayer : IntervalPlayer {
    var direction: Direction!
    var intervalPlaying: IntervalPlaying!
    
    override func randomReset() {
        direction = Direction.allCases.randomElement()!
        intervalPlaying = IntervalPlaying.allCases.randomElement()!
        super.randomReset()
    }
    
    override func setInterval(root: UInt8, interval: UInt8) {
        self.root = root
        self.interval = interval
        let intervalNote = root + interval
        let rootNoteEvents = [
            0x00, 0x90, root, 0x60, // Play the root.
            0x01, 0x80, root, 0x00, // Stop playing the root.
        ]
        let intervalNoteEvents = [
            0x00, 0x90, intervalNote, 0x60, // Play the interval.
            0x01, 0x80, intervalNote, 0x00, // Stop playing the interval.
        ]
        let blockIntervalEvents = [
            0x01, 0x90, root, 0x60, // Play the root.
            0x00, 0x90, intervalNote, 0x60, // Play the interval.
            0x01, 0x80, root, 0x00, // Stop playing the root.
            0x00, 0x80, intervalNote, 0x00, // Stop playing the interval.
        ]

        var sequence: [UInt8]
        if intervalPlaying! == .melodic {
            sequence = (direction == Direction.ascending ?
                            rootNoteEvents + intervalNoteEvents :
                            intervalNoteEvents + rootNoteEvents)
        } else {
            sequence = blockIntervalEvents
        }
        
        self.midiPlayer.setSequence(sequence)
    }
}

final class TwoNotesIntervalPlayer : IntervalPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorThird, Note.MajorThird])
    }
}

final class ThreeNotesIntervalPlayer : IntervalPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorThird, Note.MajorThird, Note.PerfectFifth])
    }
}

final class FourNotesIntervalPlayer : IntervalPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorThird, Note.MajorThird, Note.PerfectForth, Note.PerfectFifth])
    }
}

final class FiveNotesIntervalPlayer : IntervalPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorThird, Note.MajorThird, Note.PerfectForth, Note.PerfectFifth, Note.Octave])
    }
}

final class SevenNotesIntervalPlayer : IntervalMelodicAndHarmonicPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorThird, Note.MajorThird, Note.PerfectForth, Note.PerfectFifth, Note.MinorSixth, Note.MajorSixth, Note.Octave])
    }
}

final class NineNotesIntervalPlayer : IntervalMelodicAndHarmonicPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorSecond, Note.MajorSecond, Note.MinorThird, Note.MajorThird, Note.PerfectForth, Note.PerfectFifth, Note.MinorSixth, Note.MajorSixth, Note.Octave])
    }
}

final class ElevenNotesIntervalPlayer : IntervalMelodicAndHarmonicPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorSecond, Note.MajorSecond, Note.MinorThird, Note.MajorThird, Note.PerfectForth, Note.PerfectFifth, Note.MinorSixth, Note.MajorSixth, Note.MinorSeventh, Note.MajorSeventh, Note.Octave])
    }
}

final class TwelveNotesIntervalPlayer : IntervalMelodicAndHarmonicPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorSecond, Note.MajorSecond, Note.MinorThird, Note.MajorThird, Note.PerfectForth, Note.Tritone, Note.PerfectFifth, Note.MinorSixth, Note.MajorSixth, Note.MinorSeventh, Note.MajorSeventh, Note.Octave])
    }
}

final class FourteenNotesIntervalPlayer : IntervalMelodicOrHarmonicPlayer {
    required convenience init() {
        self.init(possibleNotes: [Note.MinorSecond, Note.MajorSecond, Note.MinorThird, Note.MajorThird, Note.PerfectForth, Note.Tritone, Note.PerfectFifth, Note.MinorSixth, Note.MajorSixth, Note.MinorSeventh, Note.MajorSeventh, Note.Octave, Note.MinorNineth, Note.MajorNineth])
    }
}
